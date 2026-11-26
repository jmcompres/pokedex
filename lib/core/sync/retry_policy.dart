import 'dart:math';

import 'package:pokedex/core/errors/failures.dart';

class RetryPolicy {
  final Duration initialDelay;
  final double factor;
  final Duration maxDelay;
  final int maxAttempts;
  final double jitterRatio;
  final Random? random;

  const RetryPolicy({
    this.initialDelay = const Duration(seconds: 2),
    this.factor = 2.0,
    this.maxDelay = const Duration(seconds: 60),
    this.maxAttempts = 5,
    this.jitterRatio = 0.2,
    this.random,
  });

  bool isRetryable(Failure failure) => switch (failure) {
    NetworkFailure() => true,
    TimeoutFailure() => true,
    RateLimitFailure() => true,
    ServerFailure(:final statusCode) =>
      statusCode == null || (statusCode >= 500 && statusCode < 600),
    GraphQLFailure() => false,
    CacheFailure() => false,
    ValidationFailure() => false,
  };

  bool canRetry(Failure failure, int attempt) =>
      isRetryable(failure) && attempt >= 1 && attempt < maxAttempts;

  Duration delayFor({required int attempt, Failure? failure}) {
    final exponent = max(0, attempt - 1);
    final rawMs = initialDelay.inMilliseconds * pow(factor, exponent);
    final maxMs = maxDelay.inMilliseconds;
    final cappedMs = rawMs.clamp(0, maxMs).toDouble();

    final int delayMs;
    if (jitterRatio > 0 && cappedMs > 0) {
      final rng = random ?? Random();
      final jitterFactor = (rng.nextDouble() * 2 - 1) * jitterRatio;
      delayMs = (cappedMs * (1 + jitterFactor)).round().clamp(0, maxMs);
    } else {
      delayMs = cappedMs.round();
    }

    var delay = Duration(milliseconds: delayMs);
    if (failure is RateLimitFailure && failure.retryAfter != null) {
      final retryAfter = failure.retryAfter!;
      if (retryAfter > delay) {
        delay = retryAfter;
      }
    }
    return delay;
  }
}
