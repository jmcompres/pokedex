import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';
import 'package:pokedex/core/presentation/pokedex_scaffold.dart';

class TriviaScreen extends StatelessWidget {
  const TriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PokedexScaffold(
      title: 'Trivia',
      body: PlaceholderView(
        icon: Icons.quiz_outlined,
        title: 'Trivia en implementación',
        message: 'La trivia aparecerá aquí.',
      ),
    );
  }
}
