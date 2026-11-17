import 'package:drift/drift.dart';

import 'abilities_table.dart';
import 'pokemon_table.dart';

@DataClassName('PokemonAbilityRow')
@TableIndex(name: 'idx_pokemon_ability_ability', columns: {#abilityId})
class PokemonAbilitiesTable extends Table {
  @override
  String get tableName => 'pokemon_ability';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get abilityId => integer().references(AbilitiesTable, #id)();
  IntColumn get slot => integer()();
  BoolColumn get isHidden => boolean()();

  @override
  Set<Column> get primaryKey => {pokemonId, slot};
}
