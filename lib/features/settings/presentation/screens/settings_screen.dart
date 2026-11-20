import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: const PlaceholderView(
        icon: Icons.settings_outlined,
        title: 'Ajustes en implementación',
        message: 'Los ajustes aparecerán aquí.',
      ),
    );
  }
}
