import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/app/bootstrap/bootstrap.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/presentation/connectivity/connectivity_banner_state.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/features/pokemon/data/pokemon_data_providers.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_images.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_catalog_screen.dart';

import '../../../helpers/fake_pokemon_repository.dart';

Pokemon _samplePokemon(int id, String name) => Pokemon(
  id: id,
  speciesId: id,
  name: name,
  speciesName: name,
  isDefault: true,
  types: const [PokemonType(id: 12, name: 'grass')],
  baseStats: const BaseStats(
    hp: 45,
    attack: 49,
    defense: 49,
    specialAttack: 65,
    specialDefense: 65,
    speed: 45,
  ),
  images: const PokemonImages(),
);

void main() {
  testWidgets(
    'PA-01: primera ejecución con Internet muestra UI inmediata, '
    'incorpora ítems progresivamente permitiendo scroll y registra última sync',
    (tester) async {
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
          serviceAvailabilityProvider.overrideWithValue(
            ServiceAvailability.online,
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: PokemonCatalogScreen()),
        ),
      );

      expect(find.text('Catálogo Pokémon'), findsOneWidget);
      expect(find.bySemanticsLabel('Cargando catálogo'), findsOneWidget);

      fakeRepo.emitCatalog(const []);
      fakeRepo.emitSyncStatus(const SyncInProgress(synced: 0, total: 100));
      await tester.pump();
      await tester.pump();

      expect(find.textContaining('Sincronizando'), findsWidgets);

      final lote1 = [
        for (var i = 1; i <= 15; i++) _samplePokemon(i, 'pokemon-$i'),
      ];
      fakeRepo.emitCatalog(lote1);
      fakeRepo.emitSyncStatus(const SyncInProgress(synced: 50, total: 100));
      await tester.pump();
      await tester.pump();

      expect(find.text('Sincronizando catálogo'), findsOneWidget);
      expect(find.text('50 de 100'), findsOneWidget);
      expect(find.text('15 cargadas'), findsOneWidget);

      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pump();

      await tester.drag(find.byType(ListView), const Offset(0, 300));
      await tester.pump();

      final lote2 = [
        ...lote1,
        for (var i = 16; i <= 30; i++) _samplePokemon(i, 'pokemon-$i'),
      ];
      fakeRepo.emitCatalog(lote2);
      fakeRepo.emitSyncStatus(const SyncCompleted());
      fakeRepo.emitLastSync(
        LastSync(at: DateTime(2026, 11, 16, 10, 42), origin: DataOrigin.remote),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sincronizando catálogo'), findsNothing);
      expect(find.text('30 especies'), findsOneWidget);
      expect(
        container.read(connectivityBannerStateProvider).mode,
        ConnectivityBannerMode.online,
      );
      expect(find.textContaining('10:42'), findsOneWidget);
    },
  );

  testWidgets(
    'PA-15: primera ejecución sin Internet muestra estado vacío explicativo '
    'con acción sugerida, sin errores ni pantallas en blanco',
    (tester) async {
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
          serviceAvailabilityProvider.overrideWithValue(
            ServiceAvailability.offline,
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: PokemonCatalogScreen()),
        ),
      );

      fakeRepo.emitCatalog(const []);
      fakeRepo.emitSyncStatus(const SyncFailed(NetworkFailure()));
      await tester.pump();
      await tester.pump();

      expect(
        find.text('Conéctate a Internet para descargar el catálogo'),
        findsOneWidget,
      );
      expect(find.text('Esperando conexión'), findsOneWidget);

      final retryButton = find.text('Reintentar ahora');
      expect(retryButton, findsOneWidget);

      await tester.ensureVisible(retryButton);
      await tester.pumpAndSettle();
      await tester.tap(retryButton);
      await tester.pump();

      expect(fakeRepo.refreshCalls, 1);
    },
  );
}
