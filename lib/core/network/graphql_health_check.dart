import 'package:flutter/foundation.dart';

import 'graphql_service.dart';
import 'network_contracts.dart';

class PokeApiGraphQLHealthCheck implements GraphQLHealthCheck {
  final GraphQLService _graphQLService;
  final Duration timeout;
  final bool Function()? isOutageSimulated;
  static const String _healthCheckQuery = r'''
    query HealthCheck {
      __typename
    }
  ''';

  PokeApiGraphQLHealthCheck(
    this._graphQLService, {
    this.timeout = const Duration(seconds: 4),
    this.isOutageSimulated,
  });

  @override
  Future<bool> checkHealth() async {
    if (kDebugMode && (isOutageSimulated?.call() ?? false)) return false;

    try {
      final result = await _graphQLService.performQuery(
        _healthCheckQuery,
        operationName: 'HealthCheck',
        timeout: timeout,
      );

      final typename = result.data?['__typename'] as String?;
      return !result.hasException && typename != null && typename.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
