import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/sync/sync_providers.dart';
import 'package:pokedex/features/pokemon/data/pokemon_data_providers.dart';

Future<void> bootstrap(Widget Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    overrides: [
      onServiceReconnectedProvider.overrideWith((ref) {
        final coordinator = ref.watch(catalogSyncCoordinatorProvider);
        return () async {
          await coordinator.syncCatalog();
        };
      }),
      globalSyncStatusProvider.overrideWith((ref) {
        return ref.watch(catalogSyncStatusProvider);
      }),
      globalLastSyncProvider.overrideWith((ref) {
        return ref.watch(catalogLastSyncProvider);
      }),
    ],
  );
  container.read(serviceAvailabilityMonitorProvider);
  unawaited(container.read(catalogSyncCoordinatorProvider).syncCatalog());

  runApp(UncontrolledProviderScope(container: container, child: builder()));
}
