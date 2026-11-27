import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/retry_policy.dart';
import 'package:pokedex/core/sync/sync_metadata_dao.dart';
import 'package:pokedex/core/sync/sync_resource_keys.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_dao.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_remote_mappers.dart';

const _ok = Ok<void, Failure>(null);

enum _WaitOutcome { completed, networkLost, manualRestart, disposed }

enum _RetryAction { retry, manualRestart, abort }

class CatalogSyncCoordinator {
  CatalogSyncCoordinator({
    required this.remote,
    required this.pokemonDao,
    required this.syncMetadataDao,
    this.retryPolicy = const RetryPolicy(),
    Stream<bool>? isConnectedStream,
    this.tickInterval = const Duration(seconds: 1),
    this.delayFn,
    this.onSyncFailed,
  }) {
    if (isConnectedStream != null) {
      _connectivitySub = isConnectedStream.listen(
        _onConnectivityChanged,
        onError: (_) {},
      );
    }
  }

  final PokemonRemoteDataSource remote;
  final PokemonDao pokemonDao;
  final SyncMetadataDao syncMetadataDao;
  final RetryPolicy retryPolicy;
  final Duration tickInterval;
  final Future<void> Function(Duration)? delayFn;
  final Future<void> Function()? onSyncFailed;

  static const _catalogMaxAge = Duration(hours: 24);
  static const _referenceMaxAge = Duration(days: 30);

  final _statusController = StreamController<SyncStatus>.broadcast();
  SyncStatus _status = const SyncIdle();
  Future<Result<void, Failure>>? _running;
  StreamSubscription<bool>? _connectivitySub;
  Completer<_WaitOutcome>? _activeWait;
  bool _isOffline = false;
  bool _disposed = false;

  Stream<SyncStatus> watchStatus() => Stream.multi((controller) {
    controller.add(_status);
    final sub = _statusController.stream.listen(controller.add);
    controller.onCancel = sub.cancel;
  });

  Future<Result<void, Failure>> syncCatalog({bool force = false}) {
    final activeWait = _activeWait;
    if (force &&
        _running != null &&
        activeWait != null &&
        !activeWait.isCompleted) {
      activeWait.complete(_WaitOutcome.manualRestart);
    }
    return _running ??= _run(force).whenComplete(() => _running = null);
  }

  Future<void> dispose() async {
    _disposed = true;
    final activeWait = _activeWait;
    if (activeWait != null && !activeWait.isCompleted) {
      activeWait.complete(_WaitOutcome.disposed);
    }
    await _connectivitySub?.cancel();
    await _statusController.close();
  }

  void _onConnectivityChanged(bool isConnected) {
    _isOffline = !isConnected;
    if (_isOffline) {
      final activeWait = _activeWait;
      if (activeWait != null && !activeWait.isCompleted) {
        activeWait.complete(_WaitOutcome.networkLost);
      }
    }
  }

  Future<Result<void, Failure>> _run(bool initialForce) async {
    var attempt = 1;
    var force = initialForce;
    var referenceSyncedThisRun = false;

    while (true) {
      var activeResource = SyncResourceKeys.catalog;
      try {
        final reference = await syncMetadataDao.get(SyncResourceKeys.reference);
        final catalog = await syncMetadataDao.get(SyncResourceKeys.catalog);
        final needsReference =
            (force && !referenceSyncedThisRun) ||
            !_isFresh(reference, _referenceMaxAge);
        final needsCatalog = force || !_isFresh(catalog, _catalogMaxAge);
        if (!needsReference && !needsCatalog) return _ok;

        _emit(const SyncInProgress(synced: 0));

        if (needsReference) {
          activeResource = SyncResourceKeys.reference;
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
          referenceSyncedThisRun = true;
        }

        if (needsCatalog) {
          activeResource = SyncResourceKeys.catalog;
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
        final action = await _handleFailure(
          failure,
          resourceKey: activeResource,
          attempt: attempt,
        );
        switch (action) {
          case _RetryAction.retry:
            attempt++;
          case _RetryAction.manualRestart:
            attempt = 1;
            force = true;
            referenceSyncedThisRun = false;
          case _RetryAction.abort:
            return Err<void, Failure>(failure);
        }
      } on Exception catch (error) {
        final failure = CacheFailure(debugMessage: '$error');
        await _recordFailureMetadata(failure, resourceKey: activeResource);
        _emit(SyncFailed(failure));
        return Err<void, Failure>(failure);
      }
    }
  }

  Future<_RetryAction> _handleFailure(
    Failure failure, {
    required String resourceKey,
    required int attempt,
  }) async {
    await _recordFailureMetadata(failure, resourceKey: resourceKey);

    if (!_disposed && !_isOffline && onSyncFailed != null) {
      unawaited(onSyncFailed!());
    }

    if (_disposed || _isOffline || !retryPolicy.canRetry(failure, attempt)) {
      if (!_disposed) {
        debugPrint(
          '[Sync] fallo definitivo (${failure.runtimeType}) en intento $attempt/${retryPolicy.maxAttempts}',
        );
        _emit(SyncFailed(failure));
      }
      return _RetryAction.abort;
    }

    final delay = retryPolicy.delayFor(attempt: attempt, failure: failure);
    final waitSeconds = (delay.inMilliseconds / 1000).ceil();
    debugPrint(
      '[Sync] intento ${attempt + 1}/${retryPolicy.maxAttempts} · espera $waitSeconds s · ${failure.runtimeType}',
    );

    final outcome = await _waitForRetry(delay, failure);
    switch (outcome) {
      case _WaitOutcome.completed:
        return _RetryAction.retry;
      case _WaitOutcome.manualRestart:
        return _RetryAction.manualRestart;
      case _WaitOutcome.networkLost:
        debugPrint('[Sync] espera cancelada por pérdida de red');
        _emit(SyncFailed(failure));
        return _RetryAction.abort;
      case _WaitOutcome.disposed:
        return _RetryAction.abort;
    }
  }

  Future<_WaitOutcome> _waitForRetry(Duration delay, Failure failure) async {
    final completer = Completer<_WaitOutcome>();
    _activeWait = completer;

    final customDelay = delayFn;
    if (customDelay != null) {
      _emit(SyncWaitingRetry(retryIn: delay, failure: failure));
      unawaited(
        customDelay(delay).then(
          (_) {
            if (!completer.isCompleted) {
              completer.complete(_WaitOutcome.completed);
            }
          },
          onError: (_) {
            if (!completer.isCompleted) {
              completer.complete(_WaitOutcome.completed);
            }
          },
        ),
      );
      try {
        return await completer.future;
      } finally {
        if (identical(_activeWait, completer)) {
          _activeWait = null;
        }
      }
    }

    if (delay <= Duration.zero) {
      _emit(SyncWaitingRetry(retryIn: Duration.zero, failure: failure));
      if (identical(_activeWait, completer)) {
        _activeWait = null;
      }
      return _WaitOutcome.completed;
    }

    final stopwatch = Stopwatch()..start();
    Timer? completionTimer;
    Timer? tickTimer;

    void emitRemaining() {
      final remainingMs = delay.inMilliseconds - stopwatch.elapsedMilliseconds;
      if (remainingMs <= 0) return;
      final remainingSeconds = (remainingMs / 1000).ceil();
      _emit(
        SyncWaitingRetry(
          retryIn: Duration(seconds: remainingSeconds),
          failure: failure,
        ),
      );
    }

    emitRemaining();
    completionTimer = Timer(delay, () {
      if (!completer.isCompleted) {
        completer.complete(_WaitOutcome.completed);
      }
    });
    tickTimer = Timer.periodic(tickInterval, (_) => emitRemaining());

    try {
      return await completer.future;
    } finally {
      completionTimer.cancel();
      tickTimer.cancel();
      stopwatch.stop();
      if (identical(_activeWait, completer)) {
        _activeWait = null;
      }
    }
  }

  Future<void> _recordFailureMetadata(
    Failure failure, {
    String resourceKey = SyncResourceKeys.catalog,
  }) async {
    try {
      await syncMetadataDao.save(
        SyncMetadataTableCompanion(
          resourceKey: Value(resourceKey),
          status: const Value(SyncStatusDb.failed),
          lastError: Value(failure.debugMessage ?? '${failure.runtimeType}'),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );
    } on Exception {
      //
    }
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
