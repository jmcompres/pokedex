import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';
import 'package:pokedex/core/presentation/pokedex_scaffold.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return PokedexScaffold(
      title: 'Pokémon #${pokemonId.toString().padLeft(4, '0')}',
      body: const PlaceholderView(
        icon: Icons.catching_pokemon,
        title: 'Detalle en construcción',
        message:
            'Aquí se verían las stats, los tipos y más detalles del pokémon',
      ),
    );
  }
}
