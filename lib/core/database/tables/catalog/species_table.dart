import 'package:drift/drift.dart';

import 'generations_table.dart';

@DataClassName('SpeciesRow')
@TableIndex(name: 'idx_species_generation', columns: {#generationId})
@TableIndex(name: 'idx_species_chain', columns: {#evolutionChainId})
class SpeciesTable extends Table {
  @override
  String get tableName => 'species';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get generationId => integer().references(GenerationsTable, #id)();
  IntColumn get evolutionChainId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
