import 'dart:math';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_remote_dtos.dart';
import 'package:pokedex/features/pokemon/data/sync/catalog_sync_coordinator.dart';

class _PokeApiFalsa implements PokemonRemoteDataSource {
  final llamadas = <String>[];
  int? fallarEnOffset;
  bool fallarEnReference = false;

  @override
  Future<ReferenceDataDto> fetchReferenceData() async {
    llamadas.add('reference');
    if (fallarEnReference) {
      throw const NetworkFailure(debugMessage: 'Fallo simulado en referencia');
    }
    return const ReferenceDataDto(
      types: [TypeDto(id: 1, name: 'normal')],
      typeEfficacy: [],
      generations: [GenerationDto(id: 1, name: 'generation-i')],
      versionGroups: [],
      eggGroups: [],
    );
  }

  @override
  Future<int> fetchPokemonCount() async => 120;

  @override
  Future<List<PokemonDto>> fetchPokemonPage({
    int limit = PokemonRemoteDataSource.defaultPageSize,
    required int offset,
  }) async {
    llamadas.add('page:$offset');
    if (offset == fallarEnOffset) {
      fallarEnOffset = null;
      throw const NetworkFailure();
    }
    return [
      for (var id = offset + 1; id <= min(offset + limit, 120); id++)
        PokemonDto(
          id: id,
          name: 'pokemon-$id',
          isDefault: true,
          species: SpeciesDto(id: id, name: 'especie-$id', generationId: 1),
          forms: [
            PokemonFormDto(
              id: id,
              name: 'pokemon-$id',
              isDefault: true,
              isMega: false,
              isBattleOnly: false,
            ),
          ],
          types: const [PokemonTypeSlotDto(slot: 1, typeId: 1)],
          stats: [
            for (final stat in PokemonDto.requiredStats)
              PokemonStatDto(baseStat: 50, name: stat),
          ],
          sprites: const PokemonSpritesDto(),
        ),
    ];
  }
}

void main() {
  test('sincroniza todo, reanuda tras un corte y no duplica', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final dao = PokemonDao(db);
    final api = _PokeApiFalsa()..fallarEnOffset = 100;
    final sync = CatalogSyncCoordinator(
      remote: api,
      pokemonDao: dao,
      syncMetadataDao: SyncMetadataDao(db),
      retryPolicy: const RetryPolicy(maxAttempts: 1),
    );
    addTearDown(sync.dispose);
    Future<int> guardados() async => (await dao.countByTable())['pokemon']!;

    expect(await sync.syncCatalog(), isA<Err<void, Failure>>());
    expect(api.llamadas, ['reference', 'page:0', 'page:50', 'page:100']);
    expect(await guardados(), 100);

    api.llamadas.clear();
    expect(await sync.syncCatalog(), isA<Ok<void, Failure>>());
    expect(api.llamadas, ['page:100']);
    expect(await guardados(), 120);

    final antes = await dao.countByTable();
    await sync.syncCatalog(force: true);
    expect(await dao.countByTable(), antes);

    api.llamadas.clear();
    api.fallarEnOffset = 0;
    expect(await sync.syncCatalog(force: true), isA<Err<void, Failure>>());
    api.llamadas.clear();
    await sync.syncCatalog();
    expect(api.llamadas, ['page:0', 'page:50', 'page:100']);
  });

  test('PA-01: primera ejecución emite lotes progresivos en Drift y registra last_success_at al completarse', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final dao = PokemonDao(db);
    final metadataDao = SyncMetadataDao(db);
    final api = _PokeApiFalsa();
    final sync = CatalogSyncCoordinator(
      remote: api,
      pokemonDao: dao,
      syncMetadataDao: metadataDao,
    );
    addTearDown(sync.dispose);

    final conteosEmitidos = <int>[];
    final estadosEmitidos = <SyncStatus>[];

    final catalogSub = dao
        .watchCatalog()
        .map((rows) => rows.length)
        .listen(conteosEmitidos.add);
    final statusSub = sync.watchStatus().listen(estadosEmitidos.add);
    addTearDown(catalogSub.cancel);
    addTearDown(statusSub.cancel);

    final resultado = await sync.syncCatalog();
    expect(resultado, isA<Ok<void, Failure>>());

    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(conteosEmitidos, containsAllInOrder([50, 100, 120]));

    expect(
      estadosEmitidos,
      containsAllInOrder([
        const SyncIdle(),
        const SyncInProgress(synced: 0),
        const SyncInProgress(synced: 0, total: 120),
        const SyncInProgress(synced: 50, total: 120),
        const SyncInProgress(synced: 100, total: 120),
        const SyncInProgress(synced: 120, total: 120),
        const SyncCompleted(),
      ]),
    );

    final metaCatalog = await metadataDao.get(SyncResourceKeys.catalog);
    final metaReference = await metadataDao.get(SyncResourceKeys.reference);

    expect(metaReference?.status, SyncStatusDb.completed);
    expect(metaReference?.lastSuccessAt, isNotNull);

    expect(metaCatalog?.status, SyncStatusDb.completed);
    expect(metaCatalog?.lastSuccessAt, isNotNull);
    expect(metaCatalog?.nextOffset, 120);
    expect(metaCatalog?.totalCount, 120);
  });

  test('PFL-16: refresco forzado (force: true) vuelve a solicitar los datos de referencia', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final dao = PokemonDao(db);
    final metadataDao = SyncMetadataDao(db);
    final api = _PokeApiFalsa();
    final sync = CatalogSyncCoordinator(
      remote: api,
      pokemonDao: dao,
      syncMetadataDao: metadataDao,
    );
    addTearDown(sync.dispose);

    // Primera sincronización para completar referencia y catálogo
    expect(await sync.syncCatalog(), isA<Ok<void, Failure>>());
    expect(api.llamadas, contains('reference'));

    // Sincronización normal sin force: no debe pedir referencia porque está fresca (30 días)
    api.llamadas.clear();
    expect(await sync.syncCatalog(force: false), isA<Ok<void, Failure>>());
    expect(api.llamadas, isEmpty);

    // Sincronización forzada con force: true: DEBE volver a pedir la referencia
    api.llamadas.clear();
    expect(await sync.syncCatalog(force: true), isA<Ok<void, Failure>>());
    expect(api.llamadas, contains('reference'));
  });

  test('PFL-16: fallo al descargar referencia registra error en sync_metadata con resource_key = reference', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final dao = PokemonDao(db);
    final metadataDao = SyncMetadataDao(db);
    final api = _PokeApiFalsa()..fallarEnReference = true;
    final sync = CatalogSyncCoordinator(
      remote: api,
      pokemonDao: dao,
      syncMetadataDao: metadataDao,
      retryPolicy: const RetryPolicy(maxAttempts: 1),
    );
    addTearDown(sync.dispose);

    final resultado = await sync.syncCatalog();
    expect(resultado, isA<Err<void, Failure>>());

    final metaRef = await metadataDao.get(SyncResourceKeys.reference);
    final metaCat = await metadataDao.get(SyncResourceKeys.catalog);

    // El error debe estar registrado en 'reference'
    expect(metaRef, isNotNull);
    expect(metaRef?.status, SyncStatusDb.failed);
    expect(metaRef?.lastError, contains('Fallo simulado en referencia'));

    // El catálogo ni siquiera debió ser marcado como fallido
    expect(metaCat, isNull);
  });
}
