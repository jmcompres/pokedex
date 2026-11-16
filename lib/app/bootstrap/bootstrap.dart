import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/images/pokemon_image_cache.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/sync/sync_providers.dart';
import 'package:pokedex/features/pokemon/data/pokemon_data_providers.dart';

ProviderContainer createBootstrapContainer({
  List<Override> additionalOverrides = const [],
}) {
  return ProviderContainer(
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
      ...additionalOverrides,
    ],
  );
}

Future<void> bootstrap(Widget Function() builder) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  PokemonImageCache.configureMemoryCache();

  final container = createBootstrapContainer();

  runApp(UncontrolledProviderScope(container: container, child: builder()));

  binding.addPostFrameCallback((_) {
    container.read(serviceAvailabilityMonitorProvider);
    unawaited(container.read(catalogSyncCoordinatorProvider).syncCatalog());
  });
}
