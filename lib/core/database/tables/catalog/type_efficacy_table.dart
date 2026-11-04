import 'package:drift/drift.dart';

import 'types_table.dart';

@DataClassName('TypeEfficacyRow')
class TypeEfficacyTable extends Table {
  @override
  String get tableName => 'type_efficacy';

  IntColumn get attackingTypeId => integer().references(TypesTable, #id)();
  IntColumn get defendingTypeId => integer().references(TypesTable, #id)();

  IntColumn get damageFactor => integer()();

  @override
  Set<Column> get primaryKey => {attackingTypeId, defendingTypeId};
}
