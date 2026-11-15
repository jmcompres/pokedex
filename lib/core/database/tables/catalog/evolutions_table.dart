import 'package:drift/drift.dart';

import 'species_table.dart';

@DataClassName('EvolutionRow')
@TableIndex(name: 'idx_evolution_from', columns: {#fromSpeciesId})
@TableIndex(name: 'idx_evolution_to', columns: {#toSpeciesId})
class EvolutionsTable extends Table {
  @override
  String get tableName => 'evolution';

  IntColumn get id => integer()();
  IntColumn get fromSpeciesId => integer().references(SpeciesTable, #id)();
  IntColumn get toSpeciesId => integer().references(SpeciesTable, #id)();

  TextColumn get triggerName => text()();
  IntColumn get minLevel => integer().nullable()();
  TextColumn get item => text().nullable()();
  IntColumn get minHappiness => integer().nullable()();
  TextColumn get timeOfDay => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
