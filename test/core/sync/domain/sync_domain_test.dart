import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/sync/domain/last_sync.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';

void main() {
  group('SyncInProgress.progress', () {
    test('calcula la fracción descargada', () {
      expect(const SyncInProgress(synced: 50, total: 200).progress, 0.25);
    });

    test('es null si el total no se conoce o es cero', () {
      expect(const SyncInProgress(synced: 50).progress, isNull);
      expect(const SyncInProgress(synced: 0, total: 0).progress, isNull);
    });
  });

  group('LastSync.isStaleAt (PS-03)', () {
    final ultimaSync = LastSync(
      at: DateTime(2026, 11, 10, 9, 15),
      origin: DataOrigin.local,
    );
    const vigencia = Duration(hours: 24);

    test('no está vencido dentro de la vigencia', () {
      expect(
        ultimaSync.isStaleAt(DateTime(2026, 11, 10, 20), vigencia),
        isFalse,
      );
    });

    test('está vencido pasada la vigencia', () {
      expect(
        ultimaSync.isStaleAt(DateTime(2026, 11, 11, 10), vigencia),
        isTrue,
      );
    });
  });
}
