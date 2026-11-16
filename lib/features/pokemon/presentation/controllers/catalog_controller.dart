import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/features/pokemon/data/pokemon_data_providers.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

sealed class CatalogState {
  const CatalogState();
}

final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

final class CatalogLoaded extends CatalogState {
  const CatalogLoaded(this.pokemon, {this.syncing});

  final List<Pokemon> pokemon;
  final SyncInProgress? syncing;
}

final class CatalogEmpty extends CatalogState {
  const CatalogEmpty({required this.offline});

  final bool offline;
}

final class CatalogError extends CatalogState {
  const CatalogError(this.failure);

  final Failure failure;
}

CatalogState resolveCatalogState(
  AsyncValue<List<Pokemon>> catalog,
  SyncStatus? sync,
) {
  return switch (catalog) {
    AsyncData(:final value) when value.isNotEmpty => CatalogLoaded(
      value,
      syncing: sync is SyncInProgress ? sync : null,
    ),

    AsyncData() => switch (sync) {
      SyncFailed(failure: NetworkFailure()) ||
      SyncWaitingRetry() => const CatalogEmpty(offline: true),
      SyncFailed(:final failure) => CatalogError(failure),
      SyncCompleted() => const CatalogEmpty(offline: false),
      SyncInProgress() || SyncIdle() || null => const CatalogLoading(),
    },

    AsyncError(:final error) => CatalogError(
      CacheFailure(debugMessage: '$error'),
    ),

    _ => const CatalogLoading(),
  };
}

final catalogStreamProvider = StreamProvider<List<Pokemon>>(
  (ref) => ref.watch(pokemonRepositoryProvider).watchCatalog(),
);

final syncStatusProvider = StreamProvider<SyncStatus>(
  (ref) => ref.watch(pokemonRepositoryProvider).watchSyncStatus(),
);

final catalogStateProvider = Provider<CatalogState>((ref) {
  final sync = switch (ref.watch(syncStatusProvider)) {
    AsyncData(:final value) => value,
    _ => null,
  };
  return resolveCatalogState(ref.watch(catalogStreamProvider), sync);
});

void refreshCatalog(WidgetRef ref) =>
    unawaited(ref.read(pokemonRepositoryProvider).refreshCatalog());
