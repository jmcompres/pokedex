import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/shell/main_shell.dart';
import 'package:pokedex/core/router/app_routes.dart';
import 'package:pokedex/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_catalog_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex/features/settings/presentation/screens/settings_screen.dart';
import 'package:pokedex/features/trivia/presentation/screens/trivia_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.catalog,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.catalog,
                builder: (context, state) => const PokemonCatalogScreen(),
                routes: [_detailRoute()],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => const FavoritesScreen(),
                routes: [_detailRoute()],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.trivia,
                builder: (context, state) => const TriviaScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

GoRoute _detailRoute() => GoRoute(
  path: AppRoutes.detailSegment,
  builder: (context, state) =>
      PokemonDetailScreen(pokemonId: int.parse(state.pathParameters['id']!)),
);
