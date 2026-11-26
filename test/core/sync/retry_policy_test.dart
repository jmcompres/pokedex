import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/sync/retry_policy.dart';

void main() {
  group('RetryPolicy.isRetryable (RNF-RES-05)', () {
    const policy = RetryPolicy();

    test('reintenta NetworkFailure, TimeoutFailure y RateLimitFailure', () {
      expect(policy.isRetryable(const NetworkFailure()), isTrue);
      expect(policy.isRetryable(const TimeoutFailure()), isTrue);
      expect(policy.isRetryable(const RateLimitFailure()), isTrue);
    });

    test('reintenta ServerFailure 5xx o sin statusCode, pero no 4xx', () {
      expect(policy.isRetryable(const ServerFailure(statusCode: 500)), isTrue);
      expect(policy.isRetryable(const ServerFailure(statusCode: 502)), isTrue);
      expect(policy.isRetryable(const ServerFailure(statusCode: 503)), isTrue);
      expect(policy.isRetryable(const ServerFailure()), isTrue);

      expect(policy.isRetryable(const ServerFailure(statusCode: 400)), isFalse);
      expect(policy.isRetryable(const ServerFailure(statusCode: 404)), isFalse);
    });

    test('no reintenta ValidationFailure, GraphQLFailure ni CacheFailure', () {
      expect(policy.isRetryable(const ValidationFailure()), isFalse);
      expect(policy.isRetryable(const GraphQLFailure()), isFalse);
      expect(policy.isRetryable(const CacheFailure()), isFalse);
    });
  });

  group('RetryPolicy.canRetry (RNF-RES-02)', () {
    const policy = RetryPolicy(maxAttempts: 5);

    test('permite reintentar intentos 1 a 4 y se detiene en el 5', () {
      const failure = TimeoutFailure();

      expect(policy.canRetry(failure, 1), isTrue);
      expect(policy.canRetry(failure, 2), isTrue);
      expect(policy.canRetry(failure, 3), isTrue);
      expect(policy.canRetry(failure, 4), isTrue);
      expect(policy.canRetry(failure, 5), isFalse);
      expect(policy.canRetry(failure, 6), isFalse);
    });

    test('rechaza intentos menores a 1', () {
      expect(policy.canRetry(const NetworkFailure(), 0), isFalse);
      expect(policy.canRetry(const NetworkFailure(), -1), isFalse);
    });

    test('rechaza fallos no reintentables incluso en el intento 1', () {
      expect(policy.canRetry(const ValidationFailure(), 1), isFalse);
      expect(policy.canRetry(const GraphQLFailure(), 1), isFalse);
      expect(policy.canRetry(const ServerFailure(statusCode: 400), 1), isFalse);
    });
  });

  group('RetryPolicy.delayFor (RNF-RES-02, PS-10)', () {
    test('calcula la progresión exponencial exacta sin jitter y aplica tope de 60 s', () {
      const policy = RetryPolicy(jitterRatio: 0);

      expect(policy.delayFor(attempt: 1), const Duration(seconds: 2));
      expect(policy.delayFor(attempt: 2), const Duration(seconds: 4));
      expect(policy.delayFor(attempt: 3), const Duration(seconds: 8));
      expect(policy.delayFor(attempt: 4), const Duration(seconds: 16));
      expect(policy.delayFor(attempt: 5), const Duration(seconds: 32));
      expect(policy.delayFor(attempt: 6), const Duration(seconds: 60));
      expect(policy.delayFor(attempt: 2000), const Duration(seconds: 60));
    });

    test('protege intentos menores a 1 devolviendo initialDelay', () {
      const policy = RetryPolicy(jitterRatio: 0);

      expect(policy.delayFor(attempt: 0), const Duration(seconds: 2));
      expect(policy.delayFor(attempt: -3), const Duration(seconds: 2));
    });

    test(
      'aplica jitter acotado en ±jitterRatio de forma determinista con Random',
      () {
        final policyA = RetryPolicy(jitterRatio: 0.2, random: Random(42));
        final policyB = RetryPolicy(jitterRatio: 0.2, random: Random(42));

        for (var i = 0; i < 10; i++) {
          final dA = policyA.delayFor(attempt: 1);
          final dB = policyB.delayFor(attempt: 1);

          expect(dA, equals(dB));
          expect(dA.inMilliseconds, inInclusiveRange(1600, 2400));
        }

        final maxWithJitter = policyA.delayFor(attempt: 6);
        expect(maxWithJitter.inMilliseconds, lessThanOrEqualTo(60000));
      },
    );

    test('en RateLimitFailure espera al menos lo indicado por Retry-After', () {
      const policy = RetryPolicy(jitterRatio: 0);

      expect(
        policy.delayFor(
          attempt: 1,
          failure: const RateLimitFailure(retryAfter: Duration(seconds: 45)),
        ),
        const Duration(seconds: 45),
      );

      expect(
        policy.delayFor(
          attempt: 6,
          failure: const RateLimitFailure(retryAfter: Duration(seconds: 90)),
        ),
        const Duration(seconds: 90),
      );

      expect(
        policy.delayFor(
          attempt: 3,
          failure: const RateLimitFailure(retryAfter: Duration(seconds: 3)),
        ),
        const Duration(seconds: 8),
      );

      expect(
        policy.delayFor(attempt: 1, failure: const RateLimitFailure()),
        const Duration(seconds: 2),
      );
    });
  });
}
