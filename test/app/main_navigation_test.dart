import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/app/bootstrap/bootstrap.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/presentation/connectivity/connectivity_banner.dart';
import 'package:pokedex/features/pokemon/data/pokemon_data_providers.dart';

import '../helpers/fake_pokemon_repository.dart';

Future<FakePokemonRepository> _pumpApp(WidgetTester tester) async {
  final fakeRepo = FakePokemonRepository();
  addTearDown(fakeRepo.dispose);

  final container = createBootstrapContainer(
    additionalOverrides: [
      pokemonRepositoryProvider.overrideWithValue(fakeRepo),
      catalogSyncStatusStreamProvider.overrideWith(
        (ref) => fakeRepo.watchSyncStatus(),
      ),
      catalogLastSyncStreamProvider.overrideWith(
        (ref) => fakeRepo.watchLastSync(),
      ),
      serviceAvailabilityProvider.overrideWithValue(ServiceAvailability.online),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: container.read(routerProvider)),
    ),
  );
  return fakeRepo;
}

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('IND-01: el indicador está en las cuatro pestañas', (
    tester,
  ) async {
    await _pumpApp(tester);

    expect(find.byType(ConnectivityBanner), findsOneWidget);

    for (final tab in ['Favoritos', 'Trivia', 'Ajustes']) {
      await tester.tap(find.widgetWithText(NavigationDestination, tab));
      await _settle(tester);

      expect(
        find.byType(ConnectivityBanner),
        findsOneWidget,
        reason: 'Falta el indicador en $tab',
      );
    }
  });
}
