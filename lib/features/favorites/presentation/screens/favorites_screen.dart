import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: const PlaceholderView(
        icon: Icons.favorite_border,
        title: 'Aún no tienes favoritos',
        message: 'Los Pokémon que marques como favoritos aparecerán aquí.',
      ),
    );
  }
}
