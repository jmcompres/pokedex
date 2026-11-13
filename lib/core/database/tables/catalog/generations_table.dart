import 'package:drift/drift.dart';

@DataClassName('GenerationRow')
class GenerationsTable extends Table {
  @override
  String get tableName => 'generation';

  IntColumn get id => integer()();
  TextColumn get name => text()();

  TextColumn get mainRegion => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
