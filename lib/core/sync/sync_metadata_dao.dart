import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';

part 'sync_metadata_dao.g.dart';

@DriftAccessor(tables: [SyncMetadataTable])
class SyncMetadataDao extends DatabaseAccessor<AppDatabase>
    with _$SyncMetadataDaoMixin {
  SyncMetadataDao(super.db);

  Stream<SyncMetadataRow?> watch(String resourceKey) {
    return (select(
      syncMetadataTable,
    )..where((t) => t.resourceKey.equals(resourceKey))).watchSingleOrNull();
  }

  Future<SyncMetadataRow?> get(String resourceKey) {
    return (select(
      syncMetadataTable,
    )..where((t) => t.resourceKey.equals(resourceKey))).getSingleOrNull();
  }

  Future<void> save(SyncMetadataTableCompanion entry) async {
    await into(syncMetadataTable).insertOnConflictUpdate(entry);
  }
}
