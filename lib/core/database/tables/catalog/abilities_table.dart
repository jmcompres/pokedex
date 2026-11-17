import 'package:drift/drift.dart';

@DataClassName('AbilityRow')
class AbilitiesTable extends Table {
  @override
  String get tableName => 'ability';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text().nullable()();

  TextColumn get effectEn => text().nullable()();
  TextColumn get effectEs => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
