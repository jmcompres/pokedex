import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/sync_metadata_dao.dart';
import 'package:pokedex/core/sync/sync_resource_keys.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_dao.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_remote_mappers.dart';

const _ok = Ok<void, Failure>(null);

class CatalogSyncCoordinator {
  CatalogSyncCoordinator({
    required this.remote,
    required this.pokemonDao,
    required this.syncMetadataDao,
  });

  final PokemonRemoteDataSource remote;
  final PokemonDao pokemonDao;
  final SyncMetadataDao syncMetadataDao;

  static const _catalogMaxAge = Duration(hours: 24);
  static const _referenceMaxAge = Duration(days: 30);

  final _statusController = StreamController<SyncStatus>.broadcast();
  SyncStatus _status = const SyncIdle();
  Future<Result<void, Failure>>? _running;

  Stream<SyncStatus> watchStatus() => Stream.multi((controller) {
    controller.add(_status);
    final sub = _statusController.stream.listen(controller.add);
    controller.onCancel = sub.cancel;
  });

  Future<Result<void, Failure>> syncCatalog({bool force = false}) =>
      _running ??= _run(force).whenComplete(() => _running = null);

  Future<void> dispose() => _statusController.close();

  Future<Result<void, Failure>> _run(bool force) async {
    try {
      final reference = await syncMetadataDao.get(SyncResourceKeys.reference);
      final catalog = await syncMetadataDao.get(SyncResourceKeys.catalog);
      final needsReference = !_isFresh(reference, _referenceMaxAge);
      final needsCatalog = force || !_isFresh(catalog, _catalogMaxAge);
      if (!needsReference && !needsCatalog) return _ok;

      _emit(const SyncInProgress(synced: 0));

      if (needsReference) {
        final data = await remote.fetchReferenceData();
        final localReference = await data.toLocalAsync();
        await pokemonDao.upsertReferenceData(
          localReference,
          progress: _meta(
            SyncResourceKeys.reference,
            SyncStatusDb.completed,
            succeeded: true,
          ),
        );
      }

      if (needsCatalog) {
        final total = await remote.fetchPokemonCount();
        var offset = _resumeOffset(catalog);
        _emit(SyncInProgress(synced: offset, total: total));

        while (offset < total) {
          final page = await remote.fetchPokemonPage(offset: offset);
          if (page.isEmpty) break;
          final localPage = await page.toCatalogPageAsync();
          offset += page.length;
          await pokemonDao.upsertCatalogPage(
            localPage,
            progress: _meta(
              SyncResourceKeys.catalog,
              SyncStatusDb.syncing,
              nextOffset: offset,
              total: total,
            ),
          );
          _emit(SyncInProgress(synced: offset, total: total));
        }
        await syncMetadataDao.save(
          _meta(
            SyncResourceKeys.catalog,
            SyncStatusDb.completed,
            nextOffset: offset,
            total: total,
            succeeded: true,
          ),
        );
      }

      _emit(const SyncCompleted());
      return _ok;
    } on Failure catch (failure) {
      return _fail(failure);
    } on Exception catch (error) {
      return _fail(CacheFailure(debugMessage: '$error'));
    }
  }

  Future<Result<void, Failure>> _fail(Failure failure) async {
    try {
      await syncMetadataDao.save(
        SyncMetadataTableCompanion(
          resourceKey: const Value(SyncResourceKeys.catalog),
          status: const Value(SyncStatusDb.failed),
          lastError: Value(failure.debugMessage ?? '${failure.runtimeType}'),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );
    } on Exception {
      //
    }
    _emit(SyncFailed(failure));
    return Err<void, Failure>(failure);
  }

  int _resumeOffset(SyncMetadataRow? meta) {
    if (meta == null) return 0;
    final cortada =
        meta.status == SyncStatusDb.syncing ||
        meta.status == SyncStatusDb.failed;
    final total = meta.totalCount;
    final faltanPaginas = total == null || meta.nextOffset < total;
    return cortada && faltanPaginas ? meta.nextOffset : 0;
  }

  bool _isFresh(SyncMetadataRow? meta, Duration maxAge) {
    final last = meta?.lastSuccessAt;
    if (meta == null || last == null) return false;
    return meta.status == SyncStatusDb.completed &&
        DateTime.now().difference(last) < maxAge;
  }

  SyncMetadataTableCompanion _meta(
    String key,
    SyncStatusDb status, {
    int nextOffset = 0,
    int? total,
    bool succeeded = false,
  }) {
    final now = DateTime.now();
    return SyncMetadataTableCompanion(
      resourceKey: Value(key),
      status: Value(status),
      nextOffset: Value(nextOffset),
      totalCount: total == null ? const Value.absent() : Value(total),
      lastAttemptAt: Value(now),
      lastError: const Value(null),
      lastSuccessAt: succeeded ? Value(now) : const Value.absent(),
    );
  }

  void _emit(SyncStatus status) {
    _status = status;
    if (!_statusController.isClosed) _statusController.add(status);
  }
}
