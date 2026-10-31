import 'package:go_router/go_router.dart';

import '/features/pokemon/presentation/screens/pokemon_catalog_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PokemonCatalogScreen(),
    ),
  ],
);
