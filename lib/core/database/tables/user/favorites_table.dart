import 'package:drift/drift.dart';

import '../catalog/pokemon_table.dart';

@DataClassName('FavoriteRow')
class FavoritesTable extends Table {
  @override
  String get tableName => 'favorite';

  IntColumn get pokemonId => integer().references(PokemonTable, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {pokemonId};
}