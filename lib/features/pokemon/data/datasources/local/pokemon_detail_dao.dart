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
}
