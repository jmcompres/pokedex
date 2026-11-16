import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
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
  SyncStatus? sync, [
  ServiceAvailability? availability,
]) {
  return switch (catalog) {
    AsyncData(:final value) when value.isNotEmpty => CatalogLoaded(
      value,
      syncing: sync is SyncInProgress ? sync : null,
    ),

    AsyncData() => switch (sync) {
      SyncFailed(failure: NetworkFailure()) ||
      SyncWaitingRetry() => const CatalogEmpty(offline: true),
      SyncFailed(:final failure) =>
        availability == ServiceAvailability.offline
            ? const CatalogEmpty(offline: true)
            : CatalogError(failure),
      SyncCompleted() => CatalogEmpty(
        offline: availability == ServiceAvailability.offline,
      ),
      SyncInProgress() => const CatalogLoading(),
      SyncIdle() || null =>
        availability == ServiceAvailability.offline
            ? const CatalogEmpty(offline: true)
            : const CatalogLoading(),
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
  final availability = ref.watch(serviceAvailabilityProvider);
  return resolveCatalogState(
    ref.watch(catalogStreamProvider),
    sync,
    availability,
  );
});

void refreshCatalog(WidgetRef ref) =>
    unawaited(ref.read(pokemonRepositoryProvider).refreshCatalog());
