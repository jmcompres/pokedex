import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_dao.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_detail_dao.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_detail_dtos.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/data/sync/detail_sync_coordinator.dart';

class _PokeApiFalsa implements PokemonRemoteDataSource {
  int llamadas = 0;

  @override
  Future<PokemonDetailDto> fetchPokemonDetail(int pokemonId) async {
    llamadas++;
    return PokemonDetailDto.fromJson(_eeveeJson)..validate();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

Map<String, dynamic> _evolucion(
  int id,
  int speciesId,
  String name,
  String item,
) => {
  'id': speciesId,
  'name': name,
  'generation_id': 1,
  'evolution_chain_id': 67,
  'evolves_from_species_id': 133,
  'pokemonevolutions': [
    {
      'id': id,
      'min_level': null,
      'min_happiness': null,
      'time_of_day': '',
      'evolutiontrigger': {'name': 'use-item'},
      'item': {'name': item},
    },
  ],
};

final _eeveeJson = <String, dynamic>{
  'id': 133,
  'pokemonabilities': [
    {
      'slot': 1,
      'is_hidden': false,
      'ability': {
        'id': 50,
        'name': 'run-away',
        'abilitynames': [
          {'name': 'Fuga'},
        ],
        'abilityeffecttexts': [
          {'short_effect': 'Can always flee.'},
        ],
        'abilityflavortexts': [
          {'flavor_text': 'Facilita la\nhuida.'},
        ],
      },
    },
  ],
  'pokemonmoves': [
    for (final vg in [1, 2, 2])
      {
        'version_group_id': vg,
        'level': 1,
        'movelearnmethod': {'name': 'level-up'},
        'move': {
          'id': 33,
          'name': 'tackle',
          'type_id': 1,
          'power': 40,
          'accuracy': 100,
          'pp': 35,
          'movedamageclass': {'name': 'physical'},
          'movenames': [
            {'name': 'Placaje'},
          ],
        },
      },
  ],
  'pokemonspecy': {
    'id': 133,
    'pokemonegggroups': [
      {'egg_group_id': 5},
    ],
    'evolutionchain': {
      'pokemonspecies': [
        {
          'id': 133,
          'name': 'eevee',
          'generation_id': 1,
          'evolution_chain_id': 67,
          'evolves_from_species_id': null,
          'pokemonevolutions': <dynamic>[],
        },
        _evolucion(61, 134, 'vaporeon', 'water-stone'),
        _evolucion(62, 135, 'jolteon', 'thunder-stone'),
        _evolucion(63, 136, 'flareon', 'fire-stone'),
      ],
    },
  },
};

void main() {
  late AppDatabase db;
  late _PokeApiFalsa api;
  late PokemonDetailDao detailDao;
  late DetailSyncCoordinator coordinator;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    api = _PokeApiFalsa();
    detailDao = PokemonDetailDao(db);
    coordinator = DetailSyncCoordinator(
      remote: api,
      detailDao: detailDao,
      syncMetadataDao: SyncMetadataDao(db),
    );

    for (final sql in [
      "INSERT INTO generation (id, name) VALUES (1, 'generation-i')",
      "INSERT INTO type (id, name) VALUES (1, 'normal')",
      "INSERT INTO version_group (id, name, generation_id) VALUES (1, 'red-blue', 1), (2, 'yellow', 1)",
      "INSERT INTO egg_group (id, name) VALUES (5, 'ground')",
      "INSERT INTO species (id, name, generation_id, evolution_chain_id) VALUES (133, 'eevee', 1, 67)",
      'INSERT INTO pokemon (id, species_id, name, is_default, hp, attack, defense, '
          'special_attack, special_defense, speed, updated_at) '
          "VALUES (133, 133, 'eevee', 1, 55, 55, 50, 45, 65, 55, 0)",
    ]) {
      await db.customStatement(sql);
    }
  });

  tearDown(() => db.close());

  Future<Map<String, int>> contarFilas() async => {
    for (final t in <TableInfo<Table, dynamic>>[
      db.abilitiesTable,
      db.pokemonAbilitiesTable,
      db.movesTable,
      db.pokemonMovesTable,
      db.speciesTable,
      db.evolutionsTable,
      db.speciesEggGroupsTable,
    ])
      t.actualTableName: await t.count().getSingle(),
  };

  test(
    'Eevee: guarda sus ramas evolutivas y 3 syncs no cambian las filas (PA-13)',
    () async {
      final resultado = await coordinator.syncDetail(133);
      expect(resultado, isA<Ok>());
      final despuesDeUna = await contarFilas();

      await coordinator.syncDetail(133, force: true);
      await coordinator.syncDetail(133, force: true);
      expect(api.llamadas, 3);
      expect(await contarFilas(), despuesDeUna);

      await coordinator.syncDetail(133);
      expect(api.llamadas, 3);

      final detalle = (await detailDao.loadDetail(133))!.toEntity();

      expect(detalle.isDownloaded, isTrue);
      expect(detalle.abilities.single.nameEs, 'Fuga');
      expect(detalle.abilities.single.effectEs, 'Facilita la huida.');
      expect(detalle.moves, hasLength(2));
      expect(detalle.evolutionChain.map((s) => s.id), [133, 134, 135, 136]);
      expect(detalle.evolutions, hasLength(3));
      expect(detalle.evolutions.every((e) => e.fromSpeciesId == 133), isTrue);
      expect(
        detalle.evolutions.map((e) => e.item),
        containsAll(['water-stone', 'thunder-stone', 'fire-stone']),
      );
      expect(detalle.eggGroups.single.name, 'ground');
      expect(detalle.versionGroups.map((v) => v.id), [1, 2]);
    },
  );
}
