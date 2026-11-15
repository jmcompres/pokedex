import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/features/pokemon/data/pokemon_data_providers.dart';

Future<void> bootstrap(Widget Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  unawaited(container.read(catalogSyncCoordinatorProvider).syncCatalog());

  runApp(UncontrolledProviderScope(container: container, child: builder()));
}
