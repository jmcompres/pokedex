import 'package:drift/drift.dart';

import 'pokemon_table.dart';


@DataClassName('PokemonFormRow')
@TableIndex(name: 'idx_pokemon_form_pokemon', columns: {#pokemonId})
class PokemonFormsTable extends Table {
  @override
  String get tableName => 'pokemon_form';

  IntColumn get id => integer()();
  IntColumn get pokemonId => integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();

  TextColumn get formName => text().nullable()();
  BoolColumn get isDefault => boolean()();
  BoolColumn get isMega => boolean()();
  BoolColumn get isBattleOnly => boolean()();
  IntColumn get formOrder => integer().nullable()();
  
  TextColumn get spriteUrl => text().nullable()();
  TextColumn get spriteShinyUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}