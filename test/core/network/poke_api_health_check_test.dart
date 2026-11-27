import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/network/graphql_health_check.dart';
import 'package:pokedex/core/network/graphql_service.dart';

GraphQLService _buildService(
  Stream<Response> Function(Request request) handler,
) {
  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: Link.function((request, [forward]) => handler(request)),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
    ),
  );
  return GraphQLService(client);
}

void main() {
  group('PokeApiGraphQLHealthCheck', () {
    test('retorna true cuando GraphQL responde con __typename', () async {
      final service = _buildService(
        (_) => Stream.value(
          const Response(
            response: <String, dynamic>{},
            data: <String, dynamic>{'__typename': 'query_root'},
          ),
        ),
      );
      final healthCheck = PokeApiGraphQLHealthCheck(service);

      expect(await healthCheck.checkHealth(), isTrue);
    });

    test('retorna false sin consultar el servicio cuando isOutageSimulated es true (PA-08)', () async {
      var queried = false;
      final service = _buildService((_) {
        queried = true;
        return Stream.value(
          const Response(
            response: <String, dynamic>{},
            data: <String, dynamic>{'__typename': 'query_root'},
          ),
        );
      });
      final healthCheck = PokeApiGraphQLHealthCheck(
        service,
        isOutageSimulated: () => true,
      );

      expect(await healthCheck.checkHealth(), isFalse);
      expect(queried, isFalse);
    });

    test('retorna false cuando GraphQLService falla', () async {
      final service = _buildService(
        (_) => Stream<Response>.value(
          const Response(
            response: <String, dynamic>{},
            errors: <GraphQLError>[GraphQLError(message: 'Error remoto')],
          ),
        ),
      );
      final healthCheck = PokeApiGraphQLHealthCheck(service);

      expect(await healthCheck.checkHealth(), isFalse);
    });
  });
}
