import 'package:drift/drift.dart';

@DataClassName('EggGroupRow')
class EggGroupsTable extends Table {
  @override
  String get tableName => 'egg_group';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
