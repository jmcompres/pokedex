import 'package:drift/drift.dart';

import 'pokemon_table.dart';
import 'types_table.dart';

@DataClassName('PokemonTypeRow')
@TableIndex(name: 'idx_pokemon_type_type', columns: {#typeId})
class PokemonTypesTable extends Table {
  @override
  String get tableName => 'pokemon_type';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get typeId => integer().references(TypesTable, #id)();
  IntColumn get slot => integer()();

  @override
  Set<Column> get primaryKey => {pokemonId, slot};
}
