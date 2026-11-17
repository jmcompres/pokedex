import 'graphql_service.dart';
import 'network_contracts.dart';

class PokeApiGraphQLHealthCheck implements GraphQLHealthCheck {
  final GraphQLService _graphQLService;
  final Duration timeout;
  static const String _healthCheckQuery = r'''
    query HealthCheck {
      __typename
    }
  ''';

  PokeApiGraphQLHealthCheck(
    this._graphQLService, {
    this.timeout = const Duration(seconds: 4),
  });

  @override
  Future<bool> checkHealth() async {
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
