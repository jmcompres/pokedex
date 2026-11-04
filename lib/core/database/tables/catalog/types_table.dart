import 'package:drift/drift.dart';

@DataClassName('TypeRow')
class TypesTable extends Table {
  @override
  String get tableName => 'type';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
