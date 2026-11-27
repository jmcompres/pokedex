import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/network/api_outage_simulator.dart';
import 'package:pokedex/core/network/graphql_service.dart';
import 'package:pokedex/core/network/network_contracts.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/sync_providers.dart';
import 'package:pokedex/features/settings/presentation/screens/settings_screen.dart';

class _FakeConnectivitySource implements NetworkConnectivitySource {
  final _controller = StreamController<bool>.broadcast();

  @override
  Future<bool> get hasNetworkConnection async => true;

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  Future<void> dispose() async {
    await _controller.close();
  }
}

GraphQLClient _buildHealthyClient() {
  return GraphQLClient(
    cache: GraphQLCache(),
    link: Link.function(
      (request, [forward]) => Stream.value(
        const Response(
          response: <String, dynamic>{},
          data: <String, dynamic>{'__typename': 'query_root'},
        ),
      ),
    ),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
    ),
  );
}

void main() {
  group('SettingsScreen (PFL-19)', () {
    testWidgets(
      'oculta las herramientas de depuración cuando debugModeOverride es false',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              serviceAvailabilityProvider.overrideWithValue(
                ServiceAvailability.online,
              ),
              globalSyncStatusProvider.overrideWithValue(const SyncIdle()),
              globalLastSyncProvider.overrideWithValue(null),
            ],
            child: const MaterialApp(
              home: SettingsScreen(debugModeOverride: false),
            ),
          ),
        );

        expect(
          find.byKey(const Key('simulate_api_outage_switch')),
          findsNothing,
        );
        expect(find.text('Simular API caída'), findsNothing);
        expect(find.text('Los ajustes aparecerán aquí.'), findsOneWidget);
      },
    );

    testWidgets(
      'en modo debug activar el switch simula API caída, ejecuta recheck y actualiza el banner (PA-08)',
      (tester) async {
        final fakeConnectivity = _FakeConnectivitySource();
        final mockClient = _buildHealthyClient();

        final container = ProviderContainer(
          overrides: [
            networkConnectivitySourceProvider.overrideWithValue(
              fakeConnectivity,
            ),
            graphqlClientProvider.overrideWithValue(mockClient),
            globalSyncStatusProvider.overrideWithValue(const SyncIdle()),
            globalLastSyncProvider.overrideWithValue(null),
          ],
        );
        addTearDown(() async {
          container.dispose();
          await fakeConnectivity.dispose();
        });

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(
              home: SettingsScreen(debugModeOverride: true),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final switchFinder = find.byKey(
          const Key('simulate_api_outage_switch'),
        );
        expect(switchFinder, findsOneWidget);
        expect(find.text('Simular API caída'), findsOneWidget);
        expect(find.text('Online'), findsOneWidget);
        expect(container.read(simulateApiOutageProvider), isFalse);

        await tester.tap(switchFinder);
        await tester.pumpAndSettle();

        expect(container.read(simulateApiOutageProvider), isTrue);
        expect(
          container.read(serviceAvailabilityProvider),
          ServiceAvailability.serviceUnavailable,
        );
        expect(find.text('Servicio no disponible'), findsOneWidget);

        await tester.tap(switchFinder);
        await tester.pumpAndSettle();

        expect(container.read(simulateApiOutageProvider), isFalse);
        expect(
          container.read(serviceAvailabilityProvider),
          ServiceAvailability.online,
        );
        expect(find.text('Online'), findsOneWidget);
      },
    );
  });
}
