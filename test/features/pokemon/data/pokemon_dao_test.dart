import 'dart:async';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';
import 'package:pokedex/core/sync/sync_metadata_dao.dart';
import 'package:pokedex/core/sync/sync_resource_keys.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/catalog_local_models.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_dao.dart';

const normal = 1;
const volador = 3;
const bicho = 7;
const fuego = 10;
const agua = 11;
const electrico = 13;
const psiquico = 14;

const referencia = ReferenceData(
  generations: [
    GenerationsTableCompanion(
      id: Value(1),
      name: Value('generation-i'),
      mainRegion: Value('kanto'),
    ),
    GenerationsTableCompanion(
      id: Value(4),
      name: Value('generation-iv'),
      mainRegion: Value('sinnoh'),
    ),
  ],
  types: [
    TypesTableCompanion(
      id: Value(normal),
      name: Value('normal'),
      nameEs: Value('normal'),
    ),
    TypesTableCompanion(
      id: Value(volador),
      name: Value('flying'),
      nameEs: Value('volador'),
    ),
    TypesTableCompanion(
      id: Value(bicho),
      name: Value('bug'),
      nameEs: Value('bicho'),
    ),
    TypesTableCompanion(
      id: Value(fuego),
      name: Value('fire'),
      nameEs: Value('fuego'),
    ),
    TypesTableCompanion(
      id: Value(agua),
      name: Value('water'),
      nameEs: Value('agua'),
    ),
    TypesTableCompanion(
      id: Value(electrico),
      name: Value('electric'),
      nameEs: Value('eléctrico'),
    ),
    TypesTableCompanion(
      id: Value(psiquico),
      name: Value('psychic'),
      nameEs: Value('psíquico'),
    ),
  ],
  typeEfficacy: [
    TypeEfficacyTableCompanion(
      attackingTypeId: Value(agua),
      defendingTypeId: Value(fuego),
      damageFactor: Value(200),
    ),
  ],
  versionGroups: [],
  eggGroups: [],
);

SyncMetadataTableCompanion progresoCatalogo(int nextOffset) =>
    SyncMetadataTableCompanion(
      resourceKey: const Value(SyncResourceKeys.catalog),
      status: const Value(SyncStatusDb.syncing),
      nextOffset: Value(nextOffset),
    );

PokemonTableCompanion pokemon({
  required int id,
  required int speciesId,
  required String name,
  bool isDefault = true,
  List<int> stats = const [50, 50, 50, 50, 50, 50],
}) => PokemonTableCompanion(
  id: Value(id),
  speciesId: Value(speciesId),
  name: Value(name),
  isDefault: Value(isDefault),
  hp: Value(stats[0]),
  attack: Value(stats[1]),
  defense: Value(stats[2]),
  specialAttack: Value(stats[3]),
  specialDefense: Value(stats[4]),
  speed: Value(stats[5]),
  updatedAt: Value(DateTime(2026, 11, 4)),
);

PokemonFormsTableCompanion forma({
  required int id,
  required int pokemonId,
  required String name,
  String? formName,
  bool isDefault = true,
}) => PokemonFormsTableCompanion(
  id: Value(id),
  pokemonId: Value(pokemonId),
  name: Value(name),
  formName: Value(formName),
  isDefault: Value(isDefault),
  isMega: const Value(false),
  isBattleOnly: const Value(false),
);

CatalogPage paginaCharizard({
  String nombre = 'charizard',
  int hp = 78,
  int tipo1 = fuego,
}) => CatalogPage(
  species: const [
    SpeciesTableCompanion(
      id: Value(6),
      name: Value('charizard'),
      generationId: Value(1),
      evolutionChainId: Value(2),
    ),
  ],
  pokemon: [
    pokemon(
      id: 6,
      speciesId: 6,
      name: nombre,
      stats: [hp, 84, 78, 109, 85, 100],
    ),
  ],
  pokemonTypes: [
    PokemonTypesTableCompanion(
      pokemonId: const Value(6),
      typeId: Value(tipo1),
      slot: const Value(1),
    ),
    const PokemonTypesTableCompanion(
      pokemonId: Value(6),
      typeId: Value(volador),
      slot: Value(2),
    ),
  ],
  forms: [forma(id: 6, pokemonId: 6, name: 'charizard')],
  formTypes: const [],
);

final paginaRaichu = CatalogPage(
  species: const [
    SpeciesTableCompanion(
      id: Value(26),
      name: Value('raichu'),
      generationId: Value(1),
      evolutionChainId: Value(10),
    ),
  ],
  pokemon: [
    pokemon(id: 26, speciesId: 26, name: 'raichu'),
    pokemon(id: 10100, speciesId: 26, name: 'raichu-alola', isDefault: false),
  ],
  pokemonTypes: const [
    PokemonTypesTableCompanion(
      pokemonId: Value(26),
      typeId: Value(electrico),
      slot: Value(1),
    ),
    PokemonTypesTableCompanion(
      pokemonId: Value(10100),
      typeId: Value(electrico),
      slot: Value(1),
    ),
    PokemonTypesTableCompanion(
      pokemonId: Value(10100),
      typeId: Value(psiquico),
      slot: Value(2),
    ),
  ],
  forms: [
    forma(id: 26, pokemonId: 26, name: 'raichu'),
    forma(id: 10202, pokemonId: 10100, name: 'raichu-alola', formName: 'alola'),
  ],
  formTypes: const [],
);

final paginaArceus = CatalogPage(
  species: const [
    SpeciesTableCompanion(
      id: Value(493),
      name: Value('arceus'),
      generationId: Value(4),
      evolutionChainId: Value(254),
    ),
  ],
  pokemon: [
    pokemon(
      id: 493,
      speciesId: 493,
      name: 'arceus',
      stats: const [120, 120, 120, 120, 120, 120],
    ),
  ],
  pokemonTypes: const [
    PokemonTypesTableCompanion(
      pokemonId: Value(493),
      typeId: Value(normal),
      slot: Value(1),
    ),
  ],
  forms: [
    forma(id: 493, pokemonId: 493, name: 'arceus-normal', formName: 'normal'),
    forma(
      id: 10041,
      pokemonId: 493,
      name: 'arceus-bug',
      formName: 'bug',
      isDefault: false,
    ),
  ],
  formTypes: const [
    PokemonFormTypesTableCompanion(
      formId: Value(10041),
      typeId: Value(bicho),
      slot: Value(1),
    ),
  ],
);

void main() {
  late AppDatabase db;
  late PokemonDao dao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    dao = PokemonDao(db);
    await dao.upsertReferenceData(
      referencia,
      progress: const SyncMetadataTableCompanion(
        resourceKey: Value(SyncResourceKeys.reference),
        status: Value(SyncStatusDb.completed),
      ),
    );
  });

  tearDown(() => db.close());

  Future<PokemonWithTypes> leerCharizard() async =>
      (await dao.watchCatalog().first).singleWhere((p) => p.pokemon.id == 6);

  Future<void> guardar(CatalogPage pagina, {int offset = 1}) =>
      dao.upsertCatalogPage(pagina, progress: progresoCatalogo(offset));

  group('upsert del catálogo', () {
    test(
      'guardar la misma página varias veces no duplica nada (PA-13)',
      () async {
        await guardar(paginaCharizard());
        final antes = await dao.countByTable();

        await guardar(paginaCharizard());
        await guardar(paginaCharizard());
        final despues = await dao.countByTable();

        expect(despues, antes);
        expect(despues['pokemon'], 1);
        expect(despues['pokemon_type'], 2);
        expect(despues['pokemon_form'], 1);
      },
    );

    test('base_stat_total lo calcula SQLite y se recalcula solo', () async {
      await guardar(paginaCharizard());
      expect((await leerCharizard()).pokemon.baseStatTotal, 534);

      await (db.update(db.pokemonTable)..where((p) => p.id.equals(6))).write(
        const PokemonTableCompanion(hp: Value(1)),
      );

      expect((await leerCharizard()).pokemon.baseStatTotal, 457);
    });

    test(
      'volver a guardar la página restaura datos alterados (base de PA-16)',
      () async {
        await guardar(paginaCharizard());

        await (db.update(db.pokemonTable)..where((p) => p.id.equals(6))).write(
          const PokemonTableCompanion(name: Value('alterado'), hp: Value(1)),
        );
        await (db.update(db.pokemonTypesTable)
              ..where((t) => t.pokemonId.equals(6) & t.slot.equals(1)))
            .write(const PokemonTypesTableCompanion(typeId: Value(agua)));

        await guardar(paginaCharizard());

        final charizard = await leerCharizard();
        expect(charizard.pokemon.name, 'charizard');
        expect(charizard.pokemon.hp, 78);
        expect(charizard.pokemon.baseStatTotal, 534);
        expect(charizard.types.map((t) => t.name), ['fire', 'flying']);
      },
    );

    test('las claves foráneas están activas', () async {
      await expectLater(
        db
            .into(db.pokemonTable)
            .insert(pokemon(id: 7, speciesId: 999, name: 'squirtle')),
        throwsA(isA<Exception>()),
      );
    });

    test('si algo falla a mitad de la página, no se guarda nada', () async {
      await guardar(paginaCharizard());

      await expectLater(
        guardar(
          paginaCharizard(nombre: 'no-deberia-guardarse', tipo1: 999),
          offset: 2,
        ),
        throwsA(isA<Exception>()),
      );

      final charizard = await leerCharizard();
      expect(charizard.pokemon.name, 'charizard');
      expect(charizard.types.map((t) => t.name), ['fire', 'flying']);

      final meta = await SyncMetadataDao(db).get(SyncResourceKeys.catalog);
      expect(meta!.nextOffset, 1);
    });
  });

  group('formas', () {
    test('el catálogo muestra solo los Pokémon por defecto', () async {
      await guardar(paginaRaichu);

      final catalogo = await dao.watchCatalog().first;
      expect(catalogo.map((p) => p.pokemon.name), ['raichu']);
      expect(catalogo.single.types.map((t) => t.name), ['electric']);

      expect(await db.select(db.pokemonTable).get(), hasLength(2));
    });

    test('la forma regional tiene un id distinto al de su Pokémon', () async {
      await guardar(paginaRaichu);
      await guardar(paginaRaichu);

      final formas = await db.select(db.pokemonFormsTable).get();
      expect(formas, hasLength(2));

      final alola = formas.singleWhere((f) => f.formName == 'alola');
      expect(alola.id, 10202);
      expect(alola.pokemonId, 10100);

      final normalRaichu = formas.singleWhere((f) => f.pokemonId == 26);
      expect(normalRaichu.formName, null);
    });

    test(
      'una forma puede sobrescribir el tipo y se restaura si se altera',
      () async {
        await guardar(paginaArceus);

        await (db.update(db.pokemonFormTypesTable)
              ..where((t) => t.formId.equals(10041) & t.slot.equals(1)))
            .write(const PokemonFormTypesTableCompanion(typeId: Value(fuego)));

        await guardar(paginaArceus);

        final tiposForma = await (db.select(
          db.pokemonFormTypesTable,
        )..where((t) => t.formId.equals(10041))).get();
        expect(tiposForma.map((t) => t.typeId), [bicho]);

        final tiposDefault = await (db.select(
          db.pokemonFormTypesTable,
        )..where((t) => t.formId.equals(493))).get();
        expect(tiposDefault, isEmpty);
      },
    );
  });

  group('datos del usuario (PS-11, OF-21)', () {
    test('la sync del catálogo no toca los favoritos', () async {
      await guardar(paginaCharizard());
      await db
          .into(db.favoritesTable)
          .insert(const FavoritesTableCompanion(pokemonId: Value(6)));

      await guardar(paginaCharizard());
      await guardar(paginaCharizard());

      final favoritos = await db.select(db.favoritesTable).get();
      expect(favoritos.map((f) => f.pokemonId), [6]);
    });

    test('no se puede borrar un Pokémon marcado como favorito', () async {
      await guardar(paginaCharizard());
      await db
          .into(db.favoritesTable)
          .insert(const FavoritesTableCompanion(pokemonId: Value(6)));

      await expectLater(
        (db.delete(db.pokemonTable)..where((p) => p.id.equals(6))).go(),
        throwsA(isA<Exception>()),
      );
      expect(await db.select(db.favoritesTable).get(), hasLength(1));
    });

    test('no se puede marcar como favorito un Pokémon inexistente', () async {
      await expectLater(
        db
            .into(db.favoritesTable)
            .insert(const FavoritesTableCompanion(pokemonId: Value(150))),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('reactividad', () {
    test('watchCatalog emite de nuevo cuando la sync escribe', () async {
      final eventos = StreamIterator(
        dao.watchCatalog().map((lista) => lista.length),
      );
      addTearDown(eventos.cancel);

      expect(await eventos.moveNext(), isTrue);
      expect(eventos.current, 0);

      await guardar(paginaCharizard());

      expect(await eventos.moveNext(), isTrue);
      expect(eventos.current, 1);
    });
  });
}
