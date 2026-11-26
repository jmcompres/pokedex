import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/database/database_providers.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/sync_providers.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

import 'datasources/local/pokemon_dao.dart';
import 'datasources/remote/pokemon_remote_datasource.dart';
import 'repositories/pokemon_repository_impl.dart';
import 'sync/catalog_sync_coordinator.dart';

final pokemonDaoProvider = Provider<PokemonDao>(
  (ref) => PokemonDao(ref.watch(appDatabaseProvider)),
);

final catalogSyncCoordinatorProvider = Provider<CatalogSyncCoordinator>((ref) {
  final coordinator = CatalogSyncCoordinator(
    remote: ref.watch(pokemonRemoteDataSourceProvider),
    pokemonDao: ref.watch(pokemonDaoProvider),
    syncMetadataDao: ref.watch(syncMetadataDaoProvider),
    retryPolicy: ref.watch(retryPolicyProvider),
    isConnectedStream: ref
        .watch(networkConnectivitySourceProvider)
        .onConnectivityChanged,
  );
  ref.onDispose(coordinator.dispose);
  return coordinator;
});

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => PokemonRepositoryImpl(
    pokemonDao: ref.watch(pokemonDaoProvider),
    syncMetadataDao: ref.watch(syncMetadataDaoProvider),
    coordinator: ref.watch(catalogSyncCoordinatorProvider),
  ),
);

final catalogSyncStatusStreamProvider = StreamProvider<SyncStatus>((ref) {
  final coordinator = ref.watch(catalogSyncCoordinatorProvider);
  return coordinator.watchStatus();
});

final catalogSyncStatusProvider = Provider<SyncStatus>((ref) {
  final asyncStatus = ref.watch(catalogSyncStatusStreamProvider);
  return asyncStatus.value ?? const SyncIdle();
});

final catalogLastSyncStreamProvider = StreamProvider<LastSync?>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.watchLastSync();
});

final catalogLastSyncProvider = Provider<LastSync?>((ref) {
  final asyncLastSync = ref.watch(catalogLastSyncStreamProvider);
  return asyncLastSync.value;
});
