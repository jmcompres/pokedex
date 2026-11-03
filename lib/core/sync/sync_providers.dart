import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/database/database_providers.dart';

import 'sync_metadata_dao.dart';

final syncMetadataDaoProvider = Provider<SyncMetadataDao>(
      (ref) => SyncMetadataDao(ref.watch(appDatabaseProvider)),
);