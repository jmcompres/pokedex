import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/errors/failures.dart';

void main() {
  group('RateLimitFailure (PFL-16)', () {
    test('incluye retryAfter en props para comparación por valor', () {
      const f1 = RateLimitFailure(
        debugMessage: '429',
        retryAfter: Duration(seconds: 30),
      );
      const f2 = RateLimitFailure(
        debugMessage: '429',
        retryAfter: Duration(seconds: 30),
      );
      const f3 = RateLimitFailure(
        debugMessage: '429',
        retryAfter: Duration(seconds: 60),
      );
      const f4 = RateLimitFailure(debugMessage: '429');

      expect(f1, equals(f2));
      expect(f1, isNot(equals(f3)));
      expect(f1, isNot(equals(f4)));
    });
  });
}
