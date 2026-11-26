import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/database/database_providers.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';

import 'retry_policy.dart';
import 'sync_metadata_dao.dart';

final syncMetadataDaoProvider = Provider<SyncMetadataDao>(
  (ref) => SyncMetadataDao(ref.watch(appDatabaseProvider)),
);

final retryPolicyProvider = Provider<RetryPolicy>((ref) => const RetryPolicy());

final globalSyncStatusProvider = Provider<SyncStatus>((ref) {
  return const SyncIdle();
});

final globalLastSyncProvider = Provider<LastSync?>((ref) {
  return null;
});
