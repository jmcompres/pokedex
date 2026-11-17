import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/sync_providers.dart';

enum ConnectivityBannerMode { online, offline, serviceUnavailable, syncing }

class ConnectivityBannerViewState extends Equatable {
  const ConnectivityBannerViewState({
    required this.mode,
    this.isVerifying = false,
    this.dataOrigin,
    this.lastSyncAt,
    this.syncedCount,
    this.totalCount,
    this.retryInSeconds,
    this.syncProgress,
  });

  factory ConnectivityBannerViewState.resolve({
    required ServiceAvailability availability,
    required SyncStatus syncStatus,
    required LastSync? lastSync,
  }) {
    final mode = _resolveMode(
      availability: availability,
      syncStatus: syncStatus,
    );

    final lastSyncAt = lastSync?.at;

    switch (mode) {
      case ConnectivityBannerMode.syncing:
        final isVerifying =
            availability == ServiceAvailability.verifying &&
            syncStatus is! SyncInProgress;
        final syncedCount = syncStatus is SyncInProgress
            ? syncStatus.synced
            : null;
        final totalCount = syncStatus is SyncInProgress
            ? syncStatus.total
            : null;
        final progress = syncStatus is SyncInProgress
            ? syncStatus.progress
            : null;

        return ConnectivityBannerViewState(
          mode: mode,
          isVerifying: isVerifying,
          dataOrigin: lastSync?.origin,
          lastSyncAt: lastSyncAt,
          syncedCount: syncedCount,
          totalCount: totalCount,
          syncProgress: progress,
        );

      case ConnectivityBannerMode.offline:
        return ConnectivityBannerViewState(
          mode: mode,
          dataOrigin: DataOrigin.local,
          lastSyncAt: lastSyncAt,
        );

      case ConnectivityBannerMode.serviceUnavailable:
        final retrySeconds = syncStatus is SyncWaitingRetry
            ? syncStatus.retryIn?.inSeconds
            : null;

        return ConnectivityBannerViewState(
          mode: mode,
          dataOrigin: DataOrigin.local,
          lastSyncAt: lastSyncAt,
          retryInSeconds: retrySeconds,
        );

      case ConnectivityBannerMode.online:
        return ConnectivityBannerViewState(
          mode: mode,
          dataOrigin: lastSync?.origin ?? DataOrigin.local,
          lastSyncAt: lastSyncAt,
        );
    }
  }

  final ConnectivityBannerMode mode;
  final bool isVerifying;
  final DataOrigin? dataOrigin;
  final DateTime? lastSyncAt;
  final int? syncedCount;
  final int? totalCount;
  final int? retryInSeconds;
  final double? syncProgress;

  static ConnectivityBannerMode _resolveMode({
    required ServiceAvailability availability,
    required SyncStatus syncStatus,
  }) {
    if (availability == ServiceAvailability.offline) {
      return ConnectivityBannerMode.offline;
    }

    if (syncStatus is SyncInProgress) {
      return ConnectivityBannerMode.syncing;
    }

    if (availability == ServiceAvailability.serviceUnavailable ||
        syncStatus is SyncWaitingRetry) {
      return ConnectivityBannerMode.serviceUnavailable;
    }

    if (availability == ServiceAvailability.verifying) {
      return ConnectivityBannerMode.syncing;
    }

    return ConnectivityBannerMode.online;
  }

  @override
  List<Object?> get props => [
    mode,
    isVerifying,
    dataOrigin,
    lastSyncAt,
    syncedCount,
    totalCount,
    retryInSeconds,
    syncProgress,
  ];
}

final connectivityBannerStateProvider = Provider<ConnectivityBannerViewState>((
  ref,
) {
  final availability = ref.watch(serviceAvailabilityProvider);
  final syncStatus = ref.watch(globalSyncStatusProvider);
  final lastSync = ref.watch(globalLastSyncProvider);

  return ConnectivityBannerViewState.resolve(
    availability: availability,
    syncStatus: syncStatus,
    lastSync: lastSync,
  );
});
