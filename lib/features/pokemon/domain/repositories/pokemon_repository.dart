import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/core/utils/result.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

abstract interface class PokemonRepository {
  Stream<List<Pokemon>> watchCatalog();
  Future<Result<void, Failure>> refreshCatalog();
  Stream<SyncStatus> watchSyncStatus();
  Stream<LastSync?> watchLastSync();
}
