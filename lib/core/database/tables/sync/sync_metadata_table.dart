import 'package:drift/drift.dart';

enum SyncStatusDb {
  idle,
  syncing,
  completed,
  failed
}

@DataClassName('SyncMetadataRow')
class SyncMetadataTable extends Table {
  @override
  String get tableName => 'sync_metadata';

  TextColumn get resourceKey => text()();
  TextColumn get status => textEnum<SyncStatusDb>()();

  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  IntColumn get nextOffset => integer().withDefault(const Constant(0))();
  IntColumn get totalCount => integer().nullable()();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {resourceKey};
}