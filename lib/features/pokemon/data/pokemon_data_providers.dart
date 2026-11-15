import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/database/database_providers.dart';

import 'datasources/local/pokemon_dao.dart';

final pokemonDaoProvider = Provider<PokemonDao>(
  (ref) => PokemonDao(ref.watch(appDatabaseProvider)),
);
