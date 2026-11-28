import 'dart:async';

import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/sync/sync_metadata_dao.dart';
import 'package:pokedex/core/sync/sync_resource_keys.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_dao.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/pokemon_detail_dao.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/data/sync/catalog_sync_coordinator.dart';
import 'package:pokedex/features/pokemon/data/sync/detail_sync_coordinator.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required this.pokemonDao,
    required this.syncMetadataDao,
    required this.coordinator,
    required this.detailDao,
    required this.detailCoordinator,
  });

  final PokemonDao pokemonDao;
  final SyncMetadataDao syncMetadataDao;
  final CatalogSyncCoordinator coordinator;
  final PokemonDetailDao detailDao;
  final DetailSyncCoordinator detailCoordinator;
  final _sessionStart = DateTime.now();

  @override
  Stream<List<Pokemon>> watchCatalog() => pokemonDao.watchCatalog().map(
    (rows) => List.unmodifiable(rows.map((row) => row.toEntity())),
  );

  @override
  Future<Result<void, Failure>> refreshCatalog() =>
      coordinator.syncCatalog(force: true);

  @override
  Stream<SyncStatus> watchSyncStatus() => coordinator.watchStatus();

  @override
  Stream<LastSync?> watchLastSync() =>
      syncMetadataDao.watch(SyncResourceKeys.catalog).map((meta) {
        final at = meta?.lastSuccessAt;
        if (at == null) return null;
        final origin = at.isBefore(_sessionStart)
            ? DataOrigin.local
            : DataOrigin.remote;
        return LastSync(at: at, origin: origin);
      });

  @override
  Stream<PokemonDetail?> watchPokemonDetail(int pokemonId) {
    //en este caso llamanos al sync porque no se había hecho antes (es ineficiente sincronizar todos los detalles, así que cuando se toque el pokemon lo hacemos por primera vez)
    unawaited(detailCoordinator.syncDetail(pokemonId));
    return detailDao
        .watchDetail(pokemonId)
        .map((local) => local?.toEntity())
        .distinct();
  }

  @override
  Future<Result<void, Failure>> refreshPokemonDetail(int pokemonId) =>
      detailCoordinator.syncDetail(pokemonId, force: true);
}
