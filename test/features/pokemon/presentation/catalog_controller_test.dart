import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_images.dart';
import 'package:pokedex/features/pokemon/presentation/controllers/catalog_controller.dart';

const pikachu = Pokemon(
  id: 25,
  speciesId: 25,
  name: 'pikachu',
  speciesName: 'pikachu',
  isDefault: true,
  types: [],
  baseStats: BaseStats(
    hp: 35,
    attack: 55,
    defense: 40,
    specialAttack: 50,
    specialDefense: 50,
    speed: 90,
  ),
  images: PokemonImages(),
);

void main() {
  test('combina la lista y la sync en los 4 estados de la pantalla', () {
    expect(
      resolveCatalogState(const AsyncLoading(), null),
      isA<CatalogLoading>(),
    );
    expect(
      resolveCatalogState(const AsyncData([]), const SyncInProgress(synced: 0)),
      isA<CatalogLoading>(),
    );

    expect(
      resolveCatalogState(
        const AsyncData([pikachu]),
        const SyncFailed(NetworkFailure()),
      ),
      isA<CatalogLoaded>(),
    );

    expect(
      resolveCatalogState(
        const AsyncData([]),
        const SyncFailed(NetworkFailure()),
      ),
      isA<CatalogEmpty>().having((s) => s.offline, 'offline', isTrue),
    );

    expect(
      resolveCatalogState(
        const AsyncData([]),
        const SyncFailed(ServerFailure()),
      ),
      isA<CatalogError>(),
    );
  });

  test('PA-15: resuelve CatalogEmpty(offline: true) de inmediato cuando no hay red ni datos locales', () {
    expect(
      resolveCatalogState(
        const AsyncData([]),
        const SyncIdle(),
        ServiceAvailability.offline,
      ),
      isA<CatalogEmpty>().having((s) => s.offline, 'offline', isTrue),
    );

    expect(
      resolveCatalogState(
        const AsyncData([]),
        null,
        ServiceAvailability.offline,
      ),
      isA<CatalogEmpty>().having((s) => s.offline, 'offline', isTrue),
    );
  });
}
