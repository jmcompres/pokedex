import 'package:drift/drift.dart' show Value;
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/sync/sync_metadata_table.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/sync_metadata_dao.dart';
import 'package:pokedex/core/sync/sync_resource_keys.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_detail_dao.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_detail_mappers.dart';

const _ok = Ok<void, Failure>(null);

class DetailSyncCoordinator {
  DetailSyncCoordinator({
    required this.remote,
    required this.detailDao,
    required this.syncMetadataDao,
  });

  final PokemonRemoteDataSource remote;
  final PokemonDetailDao detailDao;
  final SyncMetadataDao syncMetadataDao;

  static const detailMaxAge = Duration(days: 7);
  final _running =
      <
        int,
        Future<Result<void, Failure>>
      >{}; //la clave int es porque es uno para cada pokemon

  Future<Result<void, Failure>> syncDetail(
    int pokemonid, {
    bool force = false,
  }) {
    return _running[pokemonid] ??= _run(pokemonid, force).whenComplete(() {
      _running.remove(pokemonid);
    });
  }

  Future<Result<void, Failure>> _run(int pokemonId, bool force) async {
    final key = SyncResourceKeys.detail(pokemonId);
    try {
      final meta = await syncMetadataDao.get(key);
      if (!force && _isFresh(meta)) return _ok;

      await syncMetadataDao.save(
        SyncMetadataTableCompanion(
          resourceKey: Value(key),
          status: const Value(SyncStatusDb.syncing),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );

      final dto = await remote.fetchPokemonDetail(pokemonId);
      final detail = await dto.toDetailWriteAsync();

      final now = DateTime.now(); //el momento en que se completó el fetch
      await detailDao.upsertPokemonDetail(
        detail,
        progress: SyncMetadataTableCompanion(
          resourceKey: Value(key),
          status: const Value(SyncStatusDb.completed),
          lastSuccessAt: Value(now),
          lastAttemptAt: Value(now),
          lastError: const Value(null),
        ),
      );
      return _ok; //ya de aquí drift indica al dao que cambiaron los datos y ya el repository se entera por usar el watch del dao
    } on Failure catch (failure) {
      return _fail(key, failure);
    } on Exception catch (error) {
      return _fail(key, CacheFailure(debugMessage: '$error'));
    }
  }

  Future<Result<void, Failure>> _fail(String key, Failure failure) async {
    try {
      await syncMetadataDao.save(
        SyncMetadataTableCompanion(
          resourceKey: Value(key),
          status: const Value(SyncStatusDb.failed),
          lastError: Value(failure.debugMessage ?? '${failure.runtimeType}'),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );
    } on Exception {
      //
    }
    return Err<void, Failure>(failure);
  }

  bool _isFresh(SyncMetadataRow? meta) {
    final last = meta?.lastSuccessAt;
    if (meta == null || last == null) return false;
    return meta.status == SyncStatusDb.completed &&
        DateTime.now().difference(last) < detailMaxAge;
  }
}
