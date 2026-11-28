import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/catalog/abilities_table.dart';
import 'package:pokedex/core/database/tables/catalog/egg_groups_table.dart';
import 'package:pokedex/core/database/tables/catalog/evolutions_table.dart';
import 'package:pokedex/core/database/tables/catalog/moves_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_abilities_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_moves_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_types_table.dart';
import 'package:pokedex/core/database/tables/catalog/species_egg_groups_table.dart';
import 'package:pokedex/core/database/tables/catalog/species_table.dart';
import 'package:pokedex/core/database/tables/catalog/types_table.dart';
import 'package:pokedex/core/database/tables/catalog/version_groups_table.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';
import 'package:pokedex/core/sync/sync_resource_keys.dart';

import 'catalog_local_models.dart';

part 'pokemon_detail_dao.g.dart';

@DriftAccessor(
  tables: [
    PokemonTable,
    SpeciesTable,
    TypesTable,
    PokemonTypesTable,
    AbilitiesTable,
    PokemonAbilitiesTable,
    MovesTable,
    PokemonMovesTable,
    EvolutionsTable,
    EggGroupsTable,
    SpeciesEggGroupsTable,
    VersionGroupsTable,
    SyncMetadataTable,
  ],
)
class PokemonDetailDao extends DatabaseAccessor<AppDatabase>
    with _$PokemonDetailDaoMixin {
  PokemonDetailDao(super.db);

  Future<void> upsertPokemonDetail(
    PokemonDetailWrite detail, {
    required SyncMetadataTableCompanion progress,
  }) {
    final chainIds = detail.chainSpecies.map((s) => s.id.value).toList();

    return batch((b) {
      b.insertAll(
        speciesTable,
        detail.chainSpecies,
        mode: InsertMode.insertOrIgnore, //para no pisar las del catálogo
      );

      b.insertAllOnConflictUpdate(abilitiesTable, detail.abilities);
      b.insertAllOnConflictUpdate(movesTable, detail.moves);

      //primero borrar y luego insertar por si se cambian algun detalle relacionado a ese pokemon, por ejemplo que tal pokemon ya no tenga el movimiento tal, entonces se borra lo que estaba para garantizar que esté coherente con la realidad siempre
      b.deleteWhere(
        pokemonAbilitiesTable,
        (t) => t.pokemonId.equals(detail.pokemonId),
      );
      b.insertAll(pokemonAbilitiesTable, detail.pokemonAbilities);

      b.deleteWhere(
        pokemonMovesTable,
        (t) => t.pokemonId.equals(detail.pokemonId),
      );
      b.insertAll(pokemonMovesTable, detail.pokemonMoves);

      b.deleteWhere(
        speciesEggGroupsTable,
        (t) => t.speciesId.equals(detail.speciesId),
      );
      b.insertAll(speciesEggGroupsTable, detail.speciesEggGroups);

      b.deleteWhere(evolutionsTable, (t) => t.toSpeciesId.isIn(chainIds));
      b.insertAll(evolutionsTable, detail.evolutions);

      b.insertAllOnConflictUpdate(syncMetadataTable, [progress]);
    });
  }

  //esto es solo para que se active el loadDetail cada vez que se registre un cabmio en alguna de las tablas de detalle
  Stream<PokemonDetailLocal?> watchDetail(int pokemonId) {
    final cambios = customSelect(
      'SELECT 1',
      readsFrom: {
        pokemonTable,
        speciesTable,
        pokemonTypesTable,
        typesTable,
        abilitiesTable,
        pokemonAbilitiesTable,
        movesTable,
        pokemonMovesTable,
        evolutionsTable,
        eggGroupsTable,
        speciesEggGroupsTable,
        versionGroupsTable,
        syncMetadataTable,
      },
    );
    return cambios.watch().asyncMap((_) => loadDetail(pokemonId));
  }

  Future<PokemonDetailLocal?> loadDetail(int pokemonId) {
    return transaction(() async {
      final pokemon = await (select(
        pokemonTable,
      )..where((t) => t.id.equals(pokemonId))).getSingleOrNull();
      if (pokemon == null) return null;

      final species = await (select(
        speciesTable,
      )..where((t) => t.id.equals(pokemon.speciesId))).getSingle();

      final types =
          await (select(pokemonTypesTable).join([
                  innerJoin(
                    typesTable,
                    typesTable.id.equalsExp(pokemonTypesTable.typeId),
                  ),
                ])
                ..where(pokemonTypesTable.pokemonId.equals(pokemonId))
                ..orderBy([OrderingTerm.asc(pokemonTypesTable.slot)]))
              .map((r) => r.readTable(typesTable))
              .get();

      final abilities =
          await (select(pokemonAbilitiesTable).join([
                  innerJoin(
                    abilitiesTable,
                    abilitiesTable.id.equalsExp(
                      pokemonAbilitiesTable.abilityId,
                    ),
                  ),
                ])
                ..where(pokemonAbilitiesTable.pokemonId.equals(pokemonId))
                ..orderBy([OrderingTerm.asc(pokemonAbilitiesTable.slot)]))
              .map(
                (r) => (
                  link: r.readTable(pokemonAbilitiesTable),
                  ability: r.readTable(abilitiesTable),
                ),
              )
              .get();

      final moves =
          await (select(pokemonMovesTable).join([
                  innerJoin(
                    movesTable,
                    movesTable.id.equalsExp(pokemonMovesTable.moveId),
                  ),
                ])
                ..where(pokemonMovesTable.pokemonId.equals(pokemonId))
                ..orderBy([
                  OrderingTerm.asc(pokemonMovesTable.versionGroupId),
                  OrderingTerm.asc(pokemonMovesTable.levelLearned),
                ]))
              .map(
                (r) => (
                  link: r.readTable(pokemonMovesTable),
                  move: r.readTable(movesTable),
                ),
              )
              .get();

      // 0 si la especie no tiene cadena (o más bien que la cadena es ella sola)
      final chainSpecies = species.evolutionChainId == 0
          ? [species]
          : await (select(speciesTable)
                  ..where(
                    (t) => t.evolutionChainId.equals(species.evolutionChainId),
                  )
                  ..orderBy([(t) => OrderingTerm.asc(t.id)]))
                .get();

      final evolutions = await (select(
        evolutionsTable,
      )..where((t) => t.toSpeciesId.isIn(chainSpecies.map((s) => s.id)))).get();

      final eggGroups =
          await (select(speciesEggGroupsTable).join([
                innerJoin(
                  eggGroupsTable,
                  eggGroupsTable.id.equalsExp(speciesEggGroupsTable.eggGroupId),
                ),
              ])..where(speciesEggGroupsTable.speciesId.equals(species.id)))
              .map((r) => r.readTable(eggGroupsTable))
              .get();

      final varieties =
          await (select(pokemonTable)
                ..where((t) => t.speciesId.equals(species.id))
                ..orderBy([(t) => OrderingTerm.asc(t.id)]))
              .get();

      final versionGroupIds = moves.map((m) => m.link.versionGroupId).toSet();
      final versionGroups =
          await (select(versionGroupsTable)
                ..where((t) => t.id.isIn(versionGroupIds))
                ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
              .get();

      final sync =
          await (select(syncMetadataTable)..where(
                (t) => t.resourceKey.equals(SyncResourceKeys.detail(pokemonId)),
              ))
              .getSingleOrNull();

      return PokemonDetailLocal(
        pokemon: pokemon,
        species: species,
        types: types,
        abilities: abilities,
        moves: moves,
        chainSpecies: chainSpecies,
        evolutions: evolutions,
        eggGroups: eggGroups,
        varieties: varieties,
        versionGroups: versionGroups,
        sync: sync,
      );
    });
  }
}
