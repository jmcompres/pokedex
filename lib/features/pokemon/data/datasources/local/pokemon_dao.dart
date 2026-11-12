import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/catalog/egg_groups_table.dart';
import 'package:pokedex/core/database/tables/catalog/generations_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_form_types_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_forms_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_table.dart';
import 'package:pokedex/core/database/tables/catalog/pokemon_types_table.dart';
import 'package:pokedex/core/database/tables/catalog/species_table.dart';
import 'package:pokedex/core/database/tables/catalog/type_efficacy_table.dart';
import 'package:pokedex/core/database/tables/catalog/types_table.dart';
import 'package:pokedex/core/database/tables/catalog/version_groups_table.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';

import 'catalog_local_models.dart';

part 'pokemon_dao.g.dart';

@DriftAccessor(
  tables: [
    GenerationsTable,
    SpeciesTable,
    PokemonFormTypesTable,
    PokemonFormsTable,
    PokemonTable,
    TypesTable,
    PokemonTypesTable,
    TypeEfficacyTable,
    VersionGroupsTable,
    EggGroupsTable,
    SyncMetadataTable,
  ],
)
class PokemonDao extends DatabaseAccessor<AppDatabase> with _$PokemonDaoMixin {
  PokemonDao(super.db);

  Stream<List<PokemonWithTypes>> watchCatalog() {
    final query =
        select(pokemonTable).join([
            innerJoin(
                speciesTable,
                speciesTable.id.equalsExp(pokemonTable.id),
            ),
            leftOuterJoin(
              pokemonTypesTable,
              pokemonTypesTable.pokemonId.equalsExp(pokemonTable.id),
            ),
            leftOuterJoin(
              typesTable,
              typesTable.id.equalsExp(pokemonTypesTable.typeId),
            ),
          ])
          ..where(pokemonTable.isDefault.equals(true))
          ..orderBy([
            OrderingTerm.asc(pokemonTable.speciesId),
            OrderingTerm.asc(pokemonTypesTable.slot),
          ]);

    return query.watch().map((rows) {
      final byId = <int, PokemonWithTypes>{};
      for (final row in rows) {
        final pokemon = row.readTable(pokemonTable);
        final species = row.readTable(speciesTable);
        final type = row.readTableOrNull(typesTable);
        final entry = byId.putIfAbsent(
          pokemon.id,
          () => PokemonWithTypes(pokemon, species, []),
        );
        if (type != null) entry.types.add(type);
      }
      return byId.values.toList();
    });
  }

  Future<void> upsertReferenceData(
    ReferenceData data, {
    required SyncMetadataTableCompanion progress,
  }) {
    return batch((b) {
      b.insertAllOnConflictUpdate(generationsTable, data.generations);
      b.insertAllOnConflictUpdate(typesTable, data.types);
      b.insertAllOnConflictUpdate(versionGroupsTable, data.versionGroups);
      b.insertAllOnConflictUpdate(eggGroupsTable, data.eggGroups);
      b.insertAllOnConflictUpdate(typeEfficacyTable, data.typeEfficacy);
      b.insertAllOnConflictUpdate(syncMetadataTable, [progress]);
    });
  }

  Future<void> upsertCatalogPage(
    CatalogPage page, {
    required SyncMetadataTableCompanion progress,
  }) {
    final ids = page.pokemon.map((p) => p.id.value).toList();
    final formIds = page.forms.map((f) => f.id.value).toList();

    return batch((b) {
      b.insertAllOnConflictUpdate(speciesTable, page.species);
      b.insertAllOnConflictUpdate(pokemonTable, page.pokemon);
      b.deleteWhere(pokemonTypesTable, (t) => t.pokemonId.isIn(ids));
      b.insertAll(pokemonTypesTable, page.pokemonTypes);

      b.insertAllOnConflictUpdate(pokemonFormsTable, page.forms);
      b.deleteWhere(pokemonFormTypesTable, (t) => t.formId.isIn(formIds));
      b.insertAll(pokemonFormTypesTable, page.formTypes);

      b.insertAllOnConflictUpdate(syncMetadataTable, [progress]);
    });
  }

  Future<Map<String, int>> countByTable() async {
    final tables = <TableInfo<Table, dynamic>>[
      generationsTable,
      typesTable,
      typeEfficacyTable,
      versionGroupsTable,
      eggGroupsTable,
      speciesTable,
      pokemonFormTypesTable,
      pokemonFormsTable,
      pokemonTable,
      pokemonTypesTable,
    ];
    return {
      for (final table in tables)
        table.actualTableName: await table.count().getSingle(),
    };
  }
}
