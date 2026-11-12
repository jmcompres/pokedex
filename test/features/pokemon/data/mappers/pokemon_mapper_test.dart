import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/catalog_local_models.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

const fuego = TypeRow(id: 10, name: 'fire', nameEs: 'fuego');
const volador = TypeRow(id: 3, name: 'flying', nameEs: 'volador');
const electrico = TypeRow(id: 13, name: 'electric', nameEs: 'eléctrico');

PokemonRow fila({
  required int id,
  required int speciesId,
  required String name,
  required List<int> stats,
  String? artworkUrl,
  String? spriteUrl,
}) => PokemonRow(
  id: id,
  speciesId: speciesId,
  name: name,
  isDefault: true,
  hp: stats[0],
  attack: stats[1],
  defense: stats[2],
  specialAttack: stats[3],
  specialDefense: stats[4],
  speed: stats[5],
  baseStatTotal: stats.reduce((a, b) => a + b),
  artworkUrl: artworkUrl,
  spriteUrl: spriteUrl,
  updatedAt: DateTime(2026, 11, 11),
);

SpeciesRow especie(int id, String name, int evolutionChainId) => SpeciesRow(
  id: id,
  name: name,
  generationId: 1,
  evolutionChainId: evolutionChainId,
);

void main() {
  test('mapea un Pokémon de un solo tipo', () {
    final entrada = PokemonWithTypes(
      fila(
        id: 25,
        speciesId: 25,
        name: 'pikachu',
        stats: [35, 55, 40, 50, 50, 90],
        artworkUrl: 'https://img/25.png',
      ),
      especie(25, 'pikachu', 10),
      [electrico],
    );

    final pikachu = entrada.toEntity();

    expect(pikachu.id, 25);
    expect(pikachu.nationalDexNumber, 25);
    expect(pikachu.name, 'pikachu');
    expect(pikachu.isDefault, isTrue);
    expect(pikachu.types, const [
      PokemonType(id: 13, name: 'electric', nameEs: 'eléctrico'),
    ]);
    expect(
      pikachu.baseStats,
      const BaseStats(
        hp: 35,
        attack: 55,
        defense: 40,
        specialAttack: 50,
        specialDefense: 50,
        speed: 90,
      ),
    );
    expect(pikachu.baseStats.total, 320);
    expect(pikachu.images.preferredUrl, 'https://img/25.png');
  });

  test('mapea un Pokémon de dos tipos respetando el orden', () {
    final charizard = PokemonWithTypes(
      fila(
        id: 6,
        speciesId: 6,
        name: 'charizard',
        stats: [78, 84, 78, 109, 85, 100],
      ),
      especie(6, 'charizard', 2),
      [fuego, volador],
    ).toEntity();

    expect(charizard.types.map((t) => t.name), ['fire', 'flying']);
    expect(charizard.types.first.nameEs, 'fuego');
    expect(charizard.baseStats.total, 534);
  });

  test('el nombre visible sale de la especie', () {
    final deoxys = PokemonWithTypes(
      fila(
        id: 386,
        speciesId: 386,
        name: 'deoxys-normal',
        stats: [50, 150, 50, 150, 50, 150],
      ),
      especie(386, 'deoxys', 202),
      [const TypeRow(id: 14, name: 'psychic', nameEs: 'psíquico')],
    ).toEntity();

    expect(deoxys.name, 'deoxys-normal');
    expect(deoxys.speciesName, 'deoxys');
  });

  test('la lista de tipos de la entidad no se puede modificar', () {
    final pikachu = PokemonWithTypes(
      fila(id: 25, speciesId: 25, name: 'pikachu', stats: [1, 1, 1, 1, 1, 1]),
      especie(25, 'pikachu', 10),
      [electrico],
    ).toEntity();

    expect(
      () => pikachu.types.add(const PokemonType(id: 1, name: 'normal')),
      throwsUnsupportedError,
    );
  });
}
