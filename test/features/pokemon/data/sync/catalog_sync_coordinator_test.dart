import 'dart:async';
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
  int countCalls = 0;
  final fallosProgramadosEnReference = <Failure>[];
  final fallosProgramadosEnCount = <Failure>[];
  final fallosProgramadosEnPage = <int, List<Failure>>{};

  @override
  Future<ReferenceDataDto> fetchReferenceData() async {
    llamadas.add('reference');
    if (fallosProgramadosEnReference.isNotEmpty) {
      throw fallosProgramadosEnReference.removeAt(0);
    }
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
  Future<int> fetchPokemonCount() async {
    countCalls++;
    if (fallosProgramadosEnCount.isNotEmpty) {
      throw fallosProgramadosEnCount.removeAt(0);
    }
    return 120;
  }

  @override
  Future<List<PokemonDto>> fetchPokemonPage({
    int limit = PokemonRemoteDataSource.defaultPageSize,
    required int offset,
  }) async {
    llamadas.add('page:$offset');
    final cola = fallosProgramadosEnPage[offset];
    if (cola != null && cola.isNotEmpty) {
      throw cola.removeAt(0);
    }
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

  group('PFL-18: reintentos con backoff y manejo de errores', () {
    test('reintenta tras fallos reintentables, emite SyncWaitingRetry y completa reanudando desde offset', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final dao = PokemonDao(db);
      final metadataDao = SyncMetadataDao(db);
      final api = _PokeApiFalsa()
        ..fallosProgramadosEnPage[50] = [
          const TimeoutFailure(debugMessage: 'timeout 1'),
          const ServerFailure(statusCode: 503, debugMessage: '503'),
        ];
      final esperas = <Duration>[];
      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: dao,
        syncMetadataDao: metadataDao,
        retryPolicy: const RetryPolicy(jitterRatio: 0),
        delayFn: (delay) async => esperas.add(delay),
      );
      addTearDown(sync.dispose);

      final estados = <SyncStatus>[];
      final sub = sync.watchStatus().listen(estados.add);
      addTearDown(sub.cancel);

      final resultado = await sync.syncCatalog();
      await Future<void>.delayed(Duration.zero);
      expect(resultado, isA<Ok<void, Failure>>());

      expect(esperas, [const Duration(seconds: 2), const Duration(seconds: 4)]);
      expect(api.llamadas, [
        'reference',
        'page:0',
        'page:50',
        'page:50',
        'page:50',
        'page:100',
      ]);
      expect(
        estados,
        containsAllInOrder([
          const SyncWaitingRetry(
            retryIn: Duration(seconds: 2),
            failure: TimeoutFailure(debugMessage: 'timeout 1'),
          ),
          const SyncWaitingRetry(
            retryIn: Duration(seconds: 4),
            failure: ServerFailure(statusCode: 503, debugMessage: '503'),
          ),
          const SyncCompleted(),
        ]),
      );

      final meta = await metadataDao.get(SyncResourceKeys.catalog);
      expect(meta?.status, SyncStatusDb.completed);
      expect(meta?.lastError, isNull);
      expect((await dao.countByTable())['pokemon'], 120);
    });

    test('se detiene al agotar maxAttempts, emite SyncFailed y guarda error en sync_metadata', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final dao = PokemonDao(db);
      final metadataDao = SyncMetadataDao(db);
      final api = _PokeApiFalsa()
        ..fallosProgramadosEnCount.addAll(
          List.filled(5, const NetworkFailure(debugMessage: 'API caída')),
        );
      final esperas = <Duration>[];
      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: dao,
        syncMetadataDao: metadataDao,
        retryPolicy: const RetryPolicy(jitterRatio: 0, maxAttempts: 5),
        delayFn: (delay) async => esperas.add(delay),
      );
      addTearDown(sync.dispose);

      final estados = <SyncStatus>[];
      final sub = sync.watchStatus().listen(estados.add);
      addTearDown(sub.cancel);

      final resultado = await sync.syncCatalog();
      await Future<void>.delayed(Duration.zero);
      expect(resultado, isA<Err<void, Failure>>());
      expect(api.countCalls, 5);
      expect(esperas, const [
        Duration(seconds: 2),
        Duration(seconds: 4),
        Duration(seconds: 8),
        Duration(seconds: 16),
      ]);
      expect(
        estados.last,
        const SyncFailed(NetworkFailure(debugMessage: 'API caída')),
      );

      final meta = await metadataDao.get(SyncResourceKeys.catalog);
      expect(meta?.status, SyncStatusDb.failed);
      expect(meta?.lastError, 'API caída');
    });

    test('no reintenta ValidationFailure ni GraphQLFailure', () async {
      for (final failure in const <Failure>[
        ValidationFailure(debugMessage: 'datos inválidos'),
        GraphQLFailure(debugMessage: 'query inválida'),
      ]) {
        final db = AppDatabase(NativeDatabase.memory());
        final api = _PokeApiFalsa()..fallosProgramadosEnCount.add(failure);
        final esperas = <Duration>[];
        final sync = CatalogSyncCoordinator(
          remote: api,
          pokemonDao: PokemonDao(db),
          syncMetadataDao: SyncMetadataDao(db),
          retryPolicy: const RetryPolicy(jitterRatio: 0),
          delayFn: (delay) async => esperas.add(delay),
        );

        final estados = <SyncStatus>[];
        final sub = sync.watchStatus().listen(estados.add);
        try {
          expect(await sync.syncCatalog(), isA<Err<void, Failure>>());
          await Future<void>.delayed(Duration.zero);
          expect(api.countCalls, 1);
          expect(esperas, isEmpty);
          expect(estados.whereType<SyncWaitingRetry>(), isEmpty);
          expect(estados.last, SyncFailed(failure));
        } finally {
          await sub.cancel();
          await sync.dispose();
          await db.close();
        }
      }
    });

    test('ante RateLimitFailure espera al menos su retryAfter', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final api = _PokeApiFalsa()
        ..fallosProgramadosEnCount.add(
          const RateLimitFailure(retryAfter: Duration(seconds: 15)),
        );
      final esperas = <Duration>[];
      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: PokemonDao(db),
        syncMetadataDao: SyncMetadataDao(db),
        retryPolicy: const RetryPolicy(jitterRatio: 0),
        delayFn: (delay) async => esperas.add(delay),
      );
      addTearDown(sync.dispose);

      final resultado = await sync.syncCatalog();
      await Future<void>.delayed(Duration.zero);
      expect(resultado, isA<Ok<void, Failure>>());
      expect(esperas, [const Duration(seconds: 15)]);
    });

    test('si se pierde la red durante SyncWaitingRetry cancela la espera y reinicia al reconectar', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final connectivity = StreamController<bool>.broadcast();
      addTearDown(connectivity.close);

      final api = _PokeApiFalsa()
        ..fallosProgramadosEnCount.addAll(const [
          TimeoutFailure(debugMessage: 'fallo 1'),
          TimeoutFailure(debugMessage: 'fallo tras reconectar'),
        ]);

      final esperaIniciada = Completer<void>();
      final esperas = <Duration>[];
      var esPrimeraEspera = true;

      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: PokemonDao(db),
        syncMetadataDao: SyncMetadataDao(db),
        retryPolicy: const RetryPolicy(jitterRatio: 0),
        isConnectedStream: connectivity.stream,
        delayFn: (delay) async {
          esperas.add(delay);
          if (esPrimeraEspera) {
            esPrimeraEspera = false;
            esperaIniciada.complete();
            await Completer<void>().future;
          }
        },
      );
      addTearDown(sync.dispose);

      final primeraSync = sync.syncCatalog();
      await esperaIniciada.future;

      // Se pierde la red mientras espera: cancela sin hacer un segundo intento offline
      connectivity.add(false);
      expect(await primeraSync, isA<Err<void, Failure>>());
      expect(api.countCalls, 1);

      // Al reconectar, reinicia desde el intento 1 (espera 2 s, no 4 s)
      connectivity.add(true);
      await Future<void>.delayed(Duration.zero);
      expect(await sync.syncCatalog(), isA<Ok<void, Failure>>());
      expect(esperas, const [Duration(seconds: 2), Duration(seconds: 2)]);
    });

    test('refresco manual (force: true) durante una espera la cancela y reinicia contador', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final api = _PokeApiFalsa()
        ..fallosProgramadosEnCount.addAll(const [
          TimeoutFailure(debugMessage: 'fallo inicial'),
          TimeoutFailure(debugMessage: 'fallo tras force'),
        ]);

      final esperaIniciada = Completer<void>();
      final esperas = <Duration>[];
      var esPrimeraEspera = true;

      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: PokemonDao(db),
        syncMetadataDao: SyncMetadataDao(db),
        retryPolicy: const RetryPolicy(jitterRatio: 0),
        delayFn: (delay) async {
          esperas.add(delay);
          if (esPrimeraEspera) {
            esPrimeraEspera = false;
            esperaIniciada.complete();
            await Completer<void>().future;
          }
        },
      );
      addTearDown(sync.dispose);

      final syncEnCurso = sync.syncCatalog();
      await esperaIniciada.future;

      final syncForzada = sync.syncCatalog(force: true);
      expect(await syncEnCurso, isA<Ok<void, Failure>>());
      expect(await syncForzada, isA<Ok<void, Failure>>());
      expect(esperas, const [Duration(seconds: 2), Duration(seconds: 2)]);
    });

    test('OF-04: una GraphQLFailure en sincronización posterior conserva intactos los datos locales', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final dao = PokemonDao(db);
      final metadataDao = SyncMetadataDao(db);
      final api = _PokeApiFalsa();
      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: dao,
        syncMetadataDao: metadataDao,
        retryPolicy: const RetryPolicy(jitterRatio: 0),
        delayFn: (_) async {},
      );
      addTearDown(sync.dispose);

      expect(await sync.syncCatalog(), isA<Ok<void, Failure>>());
      expect((await dao.countByTable())['pokemon'], 120);

      api.fallosProgramadosEnPage[0] = [
        const GraphQLFailure(debugMessage: 'Respuesta parcial con errors'),
      ];

      final fallo = await sync.syncCatalog(force: true);
      expect(fallo, isA<Err<void, Failure>>());
      expect((await dao.countByTable())['pokemon'], 120);

      final meta = await metadataDao.get(SyncResourceKeys.catalog);
      expect(meta?.status, SyncStatusDb.failed);
      expect(meta?.lastError, contains('Respuesta parcial con errors'));
    });
  });

  group('PFL-19: notificación onSyncFailed', () {
    test(
      'invoca onSyncFailed cuando falla la sincronización con red activa',
      () async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        final api = _PokeApiFalsa()
          ..fallosProgramadosEnReference.add(
            const GraphQLFailure(debugMessage: 'API no disponible'),
          );
        var syncFailedCalls = 0;

        final sync = CatalogSyncCoordinator(
          remote: api,
          pokemonDao: PokemonDao(db),
          syncMetadataDao: SyncMetadataDao(db),
          retryPolicy: const RetryPolicy(jitterRatio: 0),
          delayFn: (_) async {},
          onSyncFailed: () async {
            syncFailedCalls++;
          },
        );
        addTearDown(sync.dispose);

        final result = await sync.syncCatalog();
        expect(result, isA<Err<void, Failure>>());
        expect(syncFailedCalls, 1);
      },
    );

    test('no invoca onSyncFailed cuando la red está offline', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final api = _PokeApiFalsa()
        ..fallosProgramadosEnReference.add(
          const NetworkFailure(debugMessage: 'Sin conexión'),
        );
      final connectivityController = StreamController<bool>.broadcast();
      addTearDown(connectivityController.close);
      var syncFailedCalls = 0;

      final sync = CatalogSyncCoordinator(
        remote: api,
        pokemonDao: PokemonDao(db),
        syncMetadataDao: SyncMetadataDao(db),
        retryPolicy: const RetryPolicy(jitterRatio: 0),
        isConnectedStream: connectivityController.stream,
        delayFn: (_) async {},
        onSyncFailed: () async {
          syncFailedCalls++;
        },
      );
      addTearDown(sync.dispose);

      connectivityController.add(false);
      await Future<void>.delayed(Duration.zero);

      final result = await sync.syncCatalog();
      expect(result, isA<Err<void, Failure>>());
      expect(syncFailedCalls, 0);
    });
  });
}
