import 'package:drift/drift.dart';

import 'pokemon_forms_table.dart';
import 'types_table.dart';

@DataClassName('PokemonFormTypeRow')
class PokemonFormTypesTable extends Table {
  @override
  String get tableName => 'pokemon_form_type';

  IntColumn get formId => integer().references(PokemonFormsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get typeId => integer().references(TypesTable, #id)();
  IntColumn get slot => integer()();

  @override
  Set<Column> get primaryKey => {formId, slot};
}