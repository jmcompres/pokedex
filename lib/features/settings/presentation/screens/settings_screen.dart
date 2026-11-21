import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';
import 'package:pokedex/core/presentation/pokedex_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PokedexScaffold(
      title: 'Ajustes',
      body: PlaceholderView(
        icon: Icons.settings_outlined,
        title: 'Ajustes en implementación',
        message: 'Los ajustes aparecerán aquí.',
      ),
    );
  }
}
