import 'package:drift/drift.dart';

import 'generations_table.dart';

@DataClassName('VersionGroupRow')
class VersionGroupsTable extends Table {
  @override
  String get tableName => 'version_group';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get generationId =>
      integer().nullable().references(GenerationsTable, #id)();
  IntColumn get sortOrder => integer().nullable()(); //order de pokeapi

  @override
  Set<Column> get primaryKey => {id};
}
