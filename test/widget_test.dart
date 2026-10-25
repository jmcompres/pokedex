import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/main.dart';

void main() {
  testWidgets('App renders title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PokedexApp());
    expect(find.text('Pokédex Offline-First'), findsOneWidget);
  });
}
