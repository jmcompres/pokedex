import 'package:drift/drift.dart';

import 'moves_table.dart';
import 'pokemon_table.dart';
import 'version_groups_table.dart';

@DataClassName('PokemonMoveRow')
class PokemonMovesTable extends Table {
  @override
  String get tableName => 'pokemon_move';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get versionGroupId =>
      integer().references(VersionGroupsTable, #id)();
  TextColumn get learnMethod => text()();
  IntColumn get moveId => integer().references(MovesTable, #id)();
  IntColumn get levelLearned => integer()();

  @override
  Set<Column> get primaryKey => {
    pokemonId,
    versionGroupId,
    learnMethod,
    moveId,
    levelLearned,
  };
}
