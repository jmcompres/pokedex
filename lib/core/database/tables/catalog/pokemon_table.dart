import 'package:drift/drift.dart';

import 'species_table.dart';

@DataClassName('PokemonRow')
@TableIndex(name: 'idx_pokemon_name', columns: {#name})
@TableIndex(name: 'idx_pokemon_species', columns: {#speciesId})
@TableIndex(name: 'idx_pokemon_bst', columns: {#baseStatTotal})
class PokemonTable extends Table {
  @override
  String get tableName => 'pokemon';

  IntColumn get id => integer()();
  IntColumn get speciesId => integer().references(SpeciesTable, #id)();
  TextColumn get name => text()();

  BoolColumn get isDefault => boolean()();

  IntColumn get height => integer().nullable()();
  IntColumn get weight => integer().nullable()();

  IntColumn get hp => integer()();
  IntColumn get attack => integer()();
  IntColumn get defense => integer()();
  IntColumn get specialAttack => integer()();
  IntColumn get specialDefense => integer()();
  IntColumn get speed => integer()();

  IntColumn get baseStatTotal => integer().generatedAs(
    hp + attack + defense + specialAttack + specialDefense + speed,
    stored: true,
  )();

  // imaegnes del pokemon (las de su forma por defecto, las formas extra tienen sus propios sprites en pokemon_form)
  TextColumn get spriteUrl => text().nullable()();
  TextColumn get spriteShinyUrl => text().nullable()();
  TextColumn get artworkUrl => text().nullable()();
  TextColumn get artworkShinyUrl => text().nullable()();

  TextColumn get artworkLocalPath => text().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
