import 'dart:async';

import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class FakePokemonRepository implements PokemonRepository {
  final _catalog = StreamController<List<Pokemon>>.broadcast();
  final _syncStatus = StreamController<SyncStatus>.broadcast();
  final _lastSync = StreamController<LastSync?>.broadcast();

  Result<void, Failure> refreshResult = const Ok(null);

  int refreshCalls = 0;

  void emitCatalog(List<Pokemon> pokemon) => _catalog.add(pokemon);
  void emitSyncStatus(SyncStatus status) => _syncStatus.add(status);
  void emitLastSync(LastSync? lastSync) => _lastSync.add(lastSync);

  @override
  Stream<List<Pokemon>> watchCatalog() => _catalog.stream;

  @override
  Future<Result<void, Failure>> refreshCatalog() async {
    refreshCalls++;
    return refreshResult;
  }

  @override
  Stream<SyncStatus> watchSyncStatus() => _syncStatus.stream;

  @override
  Stream<LastSync?> watchLastSync() => _lastSync.stream;

  Future<void> dispose() async {
    await _catalog.close();
    await _syncStatus.close();
    await _lastSync.close();
  }
}
