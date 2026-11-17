import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/presentation/connectivity/connectivity_banner.dart';
import 'package:pokedex/core/presentation/connectivity/connectivity_banner_state.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/sync_providers.dart';

void main() {
  final sampleSyncTime = DateTime(2026, 11, 15, 9, 15);
  final sampleLastSync = LastSync(at: sampleSyncTime, origin: DataOrigin.local);

  group('ConnectivityBannerViewState.resolve', () {
    test('prioriza offline cuando no hay red aunque syncStatus esté en progreso (§7.4)', () {
      final state = ConnectivityBannerViewState.resolve(
        availability: ServiceAvailability.offline,
        syncStatus: const SyncInProgress(synced: 20, total: 50),
        lastSync: sampleLastSync,
      );

      expect(state.mode, ConnectivityBannerMode.offline);
      expect(state.dataOrigin, DataOrigin.local);
      expect(state.lastSyncAt, sampleSyncTime);
    });

    test('resuelve a syncing con isVerifying=true mientras verifica salud de GraphQL (IND-02)', () {
      final state = ConnectivityBannerViewState.resolve(
        availability: ServiceAvailability.verifying,
        syncStatus: const SyncIdle(),
        lastSync: sampleLastSync,
      );

      expect(state.mode, ConnectivityBannerMode.syncing);
      expect(state.isVerifying, isTrue);
      expect(state.lastSyncAt, sampleSyncTime);
    });

    test('resuelve a syncing con progreso cuando SyncInProgress está activo con red', () {
      final state = ConnectivityBannerViewState.resolve(
        availability: ServiceAvailability.online,
        syncStatus: const SyncInProgress(synced: 50, total: 200),
        lastSync: sampleLastSync,
      );

      expect(state.mode, ConnectivityBannerMode.syncing);
      expect(state.isVerifying, isFalse);
      expect(state.syncedCount, 50);
      expect(state.totalCount, 200);
      expect(state.syncProgress, 0.25);
    });

    test('resuelve a serviceUnavailable cuando la API falla o espera reintento (PA-08)', () {
      final unavailableState = ConnectivityBannerViewState.resolve(
        availability: ServiceAvailability.serviceUnavailable,
        syncStatus: const SyncWaitingRetry(retryIn: Duration(seconds: 30)),
        lastSync: sampleLastSync,
      );

      expect(unavailableState.mode, ConnectivityBannerMode.serviceUnavailable);
      expect(unavailableState.retryInSeconds, 30);
      expect(unavailableState.dataOrigin, DataOrigin.local);
    });

    test('resuelve a online cuando el servicio GraphQL está disponible y sin sync activa', () {
      final state = ConnectivityBannerViewState.resolve(
        availability: ServiceAvailability.online,
        syncStatus: const SyncCompleted(),
        lastSync: sampleLastSync,
      );

      expect(state.mode, ConnectivityBannerMode.online);
      expect(state.lastSyncAt, sampleSyncTime);
    });
  });

  group('ConnectivityBanner widget (UI y Accesibilidad)', () {
    Widget buildTestWidget({
      required ServiceAvailability availability,
      SyncStatus syncStatus = const SyncIdle(),
      LastSync? lastSync,
    }) {
      return ProviderScope(
        overrides: [
          serviceAvailabilityProvider.overrideWithValue(availability),
          globalSyncStatusProvider.overrideWithValue(syncStatus),
          globalLastSyncProvider.overrideWithValue(lastSync),
        ],
        child: const MaterialApp(home: Scaffold(body: ConnectivityBanner())),
      );
    }

    testWidgets(
      'muestra estado Online con texto, icono wifi y hora de última sincronización (IND-04, IND-05)',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            availability: ServiceAvailability.online,
            lastSync: sampleLastSync,
          ),
        );

        expect(find.text('Online'), findsOneWidget);
        expect(
          find.text('Datos locales · última sincronización 09:15'),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.wifi), findsOneWidget);
      },
    );

    testWidgets(
      'muestra estado Offline con texto, icono wifi_off y vigencia o ausencia de datos locales',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            availability: ServiceAvailability.offline,
            lastSync: sampleLastSync,
          ),
        );

        expect(find.text('Offline'), findsOneWidget);
        expect(
          find.text('Datos locales · última sincronización 09:15'),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.wifi_off), findsOneWidget);

        await tester.pumpWidget(
          buildTestWidget(
            availability: ServiceAvailability.offline,
            lastSync: null,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Offline'), findsOneWidget);
        expect(find.text('Sin datos locales'), findsOneWidget);
      },
    );

    testWidgets(
      'muestra estado Servicio no disponible con texto e icono cloud_off_outlined (PA-08)',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            availability: ServiceAvailability.serviceUnavailable,
            lastSync: null,
          ),
        );

        expect(find.text('Servicio no disponible'), findsOneWidget);
        expect(
          find.text('Internet disponible · API sin respuesta'),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
      },
    );

    testWidgets(
      'se actualiza reactivamente al cambiar el estado de red (IND-03, PA-12)',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            availability: ServiceAvailability.online,
            lastSync: sampleLastSync,
          ),
        );

        expect(find.text('Online'), findsOneWidget);
        expect(find.byIcon(Icons.wifi), findsOneWidget);

        await tester.pumpWidget(
          buildTestWidget(
            availability: ServiceAvailability.offline,
            lastSync: sampleLastSync,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Offline'), findsOneWidget);
        expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      },
    );

    testWidgets(
      'expone etiqueta Semantics descriptiva para lectores de pantalla (IND-05, RNF-ACC-01)',
      (tester) async {
        final semanticsHandle = tester.ensureSemantics();
        try {
          await tester.pumpWidget(
            buildTestWidget(
              availability: ServiceAvailability.offline,
              lastSync: sampleLastSync,
            ),
          );

          expect(
            find.bySemanticsLabel(
              'Estado de conexión: Offline. Datos locales · última sincronización 09:15',
            ),
            findsOneWidget,
          );
        } finally {
          semanticsHandle.dispose();
        }
      },
    );
  });
}
