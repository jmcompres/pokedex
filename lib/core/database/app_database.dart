import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/catalog/abilities_table.dart';
import 'tables/catalog/egg_groups_table.dart';
import 'tables/catalog/evolutions_table.dart';
import 'tables/catalog/generations_table.dart';
import 'tables/catalog/moves_table.dart';
import 'tables/catalog/pokemon_abilities_table.dart';
import 'tables/catalog/pokemon_form_types_table.dart';
import 'tables/catalog/pokemon_forms_table.dart';
import 'tables/catalog/pokemon_moves_table.dart';
import 'tables/catalog/pokemon_table.dart';
import 'tables/catalog/pokemon_types_table.dart';
import 'tables/catalog/species_egg_groups_table.dart';
import 'tables/catalog/species_table.dart';
import 'tables/catalog/type_efficacy_table.dart';
import 'tables/catalog/types_table.dart';
import 'tables/catalog/version_groups_table.dart';
import 'tables/sync/sync_metadata_table.dart';
import 'tables/user/achievements_table.dart';
import 'tables/user/favorites_table.dart';
import 'tables/user/trivia_answers_table.dart';
import 'tables/user/trivia_results_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    GenerationsTable,
    SpeciesTable,
    PokemonTable,
    TypesTable,
    PokemonTypesTable,
    PokemonFormsTable,
    PokemonFormTypesTable,
    TypeEfficacyTable,
    AbilitiesTable,
    PokemonAbilitiesTable,
    VersionGroupsTable,
    MovesTable,
    PokemonMovesTable,
    EvolutionsTable,
    EggGroupsTable,
    SpeciesEggGroupsTable,

    FavoritesTable,
    TriviaResultsTable,
    TriviaAnswersTable,
    AchievementsTable,

    SyncMetadataTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'pokedex'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {},
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
