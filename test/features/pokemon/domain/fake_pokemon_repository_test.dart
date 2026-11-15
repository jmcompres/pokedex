import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_images.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

import '../../../helpers/fake_pokemon_repository.dart';

const pikachu = Pokemon(
  id: 25,
  speciesId: 25,
  name: 'pikachu',
  speciesName: 'pikachu',
  isDefault: true,
  types: [PokemonType(id: 13, name: 'electric', nameEs: 'eléctrico')],
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
  late FakePokemonRepository repo;

  setUp(() => repo = FakePokemonRepository());
  tearDown(() => repo.dispose());

  test('el catálogo se puede simular sin base ni red', () async {
    final primeraEmision = repo.watchCatalog().first;

    repo.emitCatalog([pikachu]);

    expect(await primeraEmision, [pikachu]);
  });

  test('un fallo al refrescar se maneja con switch exhaustivo', () async {
    repo.refreshResult = const Err(NetworkFailure());

    final resultado = await repo.refreshCatalog();

    final mensaje = switch (resultado) {
      Ok() => 'Catálogo actualizado',
      Err(:final error) => 'No se pudo actualizar: ${error.runtimeType}',
    };

    expect(mensaje, 'No se pudo actualizar: NetworkFailure');
    expect(repo.refreshCalls, 1);
  });
}
