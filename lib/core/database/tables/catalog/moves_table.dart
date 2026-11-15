import 'package:drift/drift.dart';

import 'types_table.dart';

@DataClassName('MoveRow')
class MovesTable extends Table {
  @override
  String get tableName => 'move';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text().nullable()();
  IntColumn get typeId => integer().nullable().references(TypesTable, #id)();
  IntColumn get power => integer().nullable()();
  IntColumn get accuracy => integer().nullable()();
  IntColumn get pp => integer().nullable()();
  TextColumn get damageClass => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
