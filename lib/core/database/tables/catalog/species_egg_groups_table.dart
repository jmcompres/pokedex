import 'package:drift/drift.dart';

import 'egg_groups_table.dart';
import 'species_table.dart';

@DataClassName('SpeciesEggGroupRow')
class SpeciesEggGroupsTable extends Table {
  @override
  String get tableName => 'species_egg_group';

  IntColumn get speciesId =>
      integer().references(SpeciesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get eggGroupId => integer().references(EggGroupsTable, #id)();

  @override
  Set<Column> get primaryKey => {speciesId, eggGroupId};
}
