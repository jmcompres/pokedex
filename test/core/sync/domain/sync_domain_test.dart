import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/errors/failures.dart';
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

  group('SyncWaitingRetry (PFL-16)', () {
    test('compara por valor retryIn y failure', () {
      const f1 = NetworkFailure(debugMessage: 'sin red');
      const f2 = NetworkFailure(debugMessage: 'sin red');
      const f3 = TimeoutFailure(debugMessage: 'timeout');

      const s1 = SyncWaitingRetry(retryIn: Duration(seconds: 5), failure: f1);
      const s2 = SyncWaitingRetry(retryIn: Duration(seconds: 5), failure: f2);
      const s3 = SyncWaitingRetry(retryIn: Duration(seconds: 5), failure: f3);
      const s4 = SyncWaitingRetry(retryIn: Duration(seconds: 10), failure: f1);
      const s5 = SyncWaitingRetry(retryIn: Duration(seconds: 5));

      expect(s1, equals(s2));
      expect(s1, isNot(equals(s3)));
      expect(s1, isNot(equals(s4)));
      expect(s1, isNot(equals(s5)));
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
