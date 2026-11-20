import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';

class TriviaScreen extends StatelessWidget {
  const TriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia')),
      body: const PlaceholderView(
        icon: Icons.quiz_outlined,
        title: 'Trivia en implementación',
        message: 'La trivia aparecerá aquí.',
      ),
    );
  }
}
