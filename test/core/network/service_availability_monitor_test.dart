import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/network_contracts.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/network/service_availability_monitor.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';

class FakeConnectivitySource implements NetworkConnectivitySource {
  FakeConnectivitySource({bool initialConnection = true})
    : _hasConnection = initialConnection;

  bool _hasConnection;
  bool throwOnCheck = false;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  @override
  Future<bool> get hasNetworkConnection async {
    if (throwOnCheck) {
      throw Exception('Simulated platform channel error');
    }
    return _hasConnection;
  }

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  void emitConnectivity(bool isConnected) {
    _hasConnection = isConnected;
    _controller.add(isConnected);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

class FakeGraphQLHealthCheck implements GraphQLHealthCheck {
  FakeGraphQLHealthCheck({this.isHealthy = true});

  bool isHealthy;
  int callCount = 0;
  Duration delay = Duration.zero;
  bool throwOnCheck = false;

  @override
  Future<bool> checkHealth() async {
    callCount++;
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    if (throwOnCheck) {
      throw Exception('Simulated unexpected health check error');
    }
    return isHealthy;
  }
}

void main() {
  group('Invariantes de modelo (§7.4)', () {
    test('ServiceAvailability nunca combina offline con API accesible', () {
      expect(ServiceAvailability.offline.isApiAccessible, isFalse);
      expect(ServiceAvailability.offline.hasNetworkConnection, isFalse);

      expect(ServiceAvailability.verifying.isApiAccessible, isFalse);
      expect(ServiceAvailability.verifying.hasNetworkConnection, isTrue);

      expect(ServiceAvailability.serviceUnavailable.isApiAccessible, isFalse);
      expect(
        ServiceAvailability.serviceUnavailable.hasNetworkConnection,
        isTrue,
      );

      expect(ServiceAvailability.online.isApiAccessible, isTrue);
      expect(ServiceAvailability.online.hasNetworkConnection, isTrue);
    });

    test('SyncStatus modela los 5 estados e identifica cuando está activo', () {
      expect(const SyncIdle().isActive, isFalse);
      expect(const SyncInProgress(synced: 50, total: 100).isActive, isTrue);
      expect(
        const SyncWaitingRetry(retryIn: Duration(seconds: 5)).isActive,
        isTrue,
      );
      expect(const SyncCompleted().isActive, isFalse);
      expect(const SyncFailed(NetworkFailure()).isActive, isFalse);
    });
  });

  group('ServiceAvailabilityMonitor', () {
    late FakeConnectivitySource fakeConnectivity;
    late FakeGraphQLHealthCheck fakeHealthCheck;
    late ServiceAvailabilityMonitor monitor;

    const testDebounce = Duration(milliseconds: 120);

    setUp(() {
      fakeConnectivity = FakeConnectivitySource(initialConnection: true);
      fakeHealthCheck = FakeGraphQLHealthCheck(isHealthy: true);
    });

    tearDown(() async {
      await monitor.dispose();
      await fakeConnectivity.dispose();
    });

    test('inicia en verifying y pasa a online si hay red y el health check responde true', () async {
      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: testDebounce,
      );

      expect(monitor.currentStatus, ServiceAvailability.verifying);

      await monitor.initialize();

      expect(monitor.currentStatus, ServiceAvailability.online);
      expect(fakeHealthCheck.callCount, 1);
    });

    test('inicia y pasa directo a offline sin ejecutar health check si no hay red inicial', () async {
      fakeConnectivity = FakeConnectivitySource(initialConnection: false);
      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: testDebounce,
      );

      await monitor.initialize();

      expect(monitor.currentStatus, ServiceAvailability.offline);
      expect(fakeHealthCheck.callCount, 0);
    });

    test('pasa a serviceUnavailable si hay red activa pero el health check GraphQL falla (PA-08)', () async {
      fakeHealthCheck.isHealthy = false;
      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: testDebounce,
      );

      await monitor.initialize();

      expect(monitor.currentStatus, ServiceAvailability.serviceUnavailable);
      expect(monitor.currentStatus.isApiAccessible, isFalse);
    });

    test('desactivar la red lleva a offline, y activarla pasa por verifying y luego a online automáticamente', () async {
      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: testDebounce,
      );

      await monitor.initialize();
      expect(monitor.currentStatus, ServiceAvailability.online);

      final emittedStates = <ServiceAvailability>[];
      final sub = monitor.statusStream.listen(emittedStates.add);

      fakeConnectivity.emitConnectivity(false);
      await Future<void>.delayed(
        testDebounce + const Duration(milliseconds: 50),
      );

      expect(monitor.currentStatus, ServiceAvailability.offline);
      expect(emittedStates, [ServiceAvailability.offline]);

      fakeHealthCheck.delay = const Duration(milliseconds: 30);
      fakeConnectivity.emitConnectivity(true);

      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(monitor.currentStatus, ServiceAvailability.verifying);

      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(monitor.currentStatus, ServiceAvailability.online);

      expect(emittedStates, [
        ServiceAvailability.offline,
        ServiceAvailability.verifying,
        ServiceAvailability.online,
      ]);

      await sub.cancel();
    });

    test('una pérdida de red menor a la ventana de debounce no produce parpadeo ni cambio de estado (IND-06)', () async {
      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: const Duration(milliseconds: 200),
      );

      await monitor.initialize();
      expect(monitor.currentStatus, ServiceAvailability.online);
      final initialHealthCalls = fakeHealthCheck.callCount;

      final emittedStates = <ServiceAvailability>[];
      final sub = monitor.statusStream.listen(emittedStates.add);

      fakeConnectivity.emitConnectivity(false);
      await Future<void>.delayed(const Duration(milliseconds: 60));
      fakeConnectivity.emitConnectivity(true);

      await Future<void>.delayed(const Duration(milliseconds: 220));

      expect(monitor.currentStatus, ServiceAvailability.online);
      expect(emittedStates, isEmpty);
      expect(fakeHealthCheck.callCount, initialHealthCalls);

      await sub.cancel();
    });

    test('dispara automáticamente el callback de sincronización al pasar de offline a online (OF-12)', () async {
      var autoSyncCalls = 0;

      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: testDebounce,
        onReconnected: () async {
          autoSyncCalls++;
        },
      );

      await monitor.initialize();
      expect(monitor.currentStatus, ServiceAvailability.online);
      expect(autoSyncCalls, 0);

      fakeConnectivity.emitConnectivity(false);
      await Future<void>.delayed(
        testDebounce + const Duration(milliseconds: 40),
      );
      expect(monitor.currentStatus, ServiceAvailability.offline);

      fakeConnectivity.emitConnectivity(true);
      await Future<void>.delayed(const Duration(milliseconds: 40));

      expect(monitor.currentStatus, ServiceAvailability.online);
      expect(autoSyncCalls, 1);
    });

    test('si al volver de offline la API falla (serviceUnavailable), pospone el auto-sync hasta que sea online', () async {
      var autoSyncCalls = 0;
      fakeConnectivity = FakeConnectivitySource(initialConnection: false);

      monitor = ServiceAvailabilityMonitor(
        connectivitySource: fakeConnectivity,
        healthCheck: fakeHealthCheck,
        offlineDebounceDuration: testDebounce,
        onReconnected: () async {
          autoSyncCalls++;
        },
      );

      await monitor.initialize();
      expect(monitor.currentStatus, ServiceAvailability.offline);

      fakeHealthCheck.isHealthy = false;
      fakeConnectivity.emitConnectivity(true);
      await Future<void>.delayed(const Duration(milliseconds: 40));

      expect(monitor.currentStatus, ServiceAvailability.serviceUnavailable);
      expect(autoSyncCalls, 0);

      fakeHealthCheck.isHealthy = true;
      await monitor.recheck();

      expect(monitor.currentStatus, ServiceAvailability.online);
      expect(autoSyncCalls, 1);
    });
  });

  group('Riverpod network_providers', () {
    test(
      'serviceAvailabilityProvider expone reactivamente el estado del monitor',
      () async {
        final fakeConnectivity = FakeConnectivitySource(
          initialConnection: true,
        );
        final fakeHealthCheck = FakeGraphQLHealthCheck(isHealthy: true);

        final container = ProviderContainer(
          overrides: [
            networkConnectivitySourceProvider.overrideWithValue(
              fakeConnectivity,
            ),
            graphQLHealthCheckProvider.overrideWithValue(fakeHealthCheck),
          ],
        );
        addTearDown(() async {
          container.dispose();
          await fakeConnectivity.dispose();
        });

        final sub = container.listen(
          serviceAvailabilityProvider,
          (_, _) {},
          fireImmediately: true,
        );

        await Future<void>.delayed(const Duration(milliseconds: 30));
        expect(sub.read(), ServiceAvailability.online);
      },
    );
  });
}
