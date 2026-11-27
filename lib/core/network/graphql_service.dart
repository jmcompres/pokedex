import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import '../errors/failures.dart';
import 'api_outage_simulator.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink('https://graphql.pokeapi.co/v1beta2');

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
    ),
  );
});

class GraphQLService {
  final GraphQLClient _client;
  static const _timeout = Duration(seconds: 15);
  final bool Function()? isOutageSimulated;

  GraphQLService(this._client, {this.isOutageSimulated});

  Future<QueryResult> performQuery(
    String query, {
    required String operationName,
    Map<String, dynamic> variables = const {},
    Duration timeout = _timeout,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      operationName: operationName,
      variables: variables,
    );

    final stopwatch = Stopwatch()..start();

    try {
      if (kDebugMode && (isOutageSimulated?.call() ?? false)) {
        throw const ServerFailure(
          debugMessage: 'Simulación de API no disponible',
          statusCode: 503,
        );
      }

      final QueryResult result = await _client.query(options).timeout(timeout);
      if (result.hasException) {
        throw _mapGraphQLException(result.exception!);
      }
      return result;
    } on TimeoutException {
      throw TimeoutFailure(
        debugMessage: 'La petición superó los ${timeout.inSeconds} segundos',
      );
    } on SocketException {
      throw const NetworkFailure(debugMessage: 'No hay conexión a Internet');
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(debugMessage: 'Error inesperado: $e');
    } finally {
      stopwatch.stop();
      final offset = variables['offset'] ?? 'N/A';
      debugPrint(
        '[GraphQL] op: $operationName | offset: $offset | duration: ${stopwatch.elapsedMilliseconds}ms',
      );
    }
  }

  Failure _mapGraphQLException(OperationException ex) {
    final linkException = ex.linkException;

    if (linkException is NetworkException) {
      return const NetworkFailure(
        debugMessage: 'Error de red en el Link de GraphQL',
      );
    }

    final graphqlErrors = ex.graphqlErrors.isNotEmpty
        ? ex.graphqlErrors
        : (linkException is ServerException
              ? (linkException.parsedResponse?.errors ?? const <GraphQLError>[])
              : const <GraphQLError>[]);

    final httpResponse = switch (linkException) {
      HttpLinkServerException(:final response) => response,
      HttpLinkParserException(:final response) => response,
      _ => null,
    };

    if (httpResponse != null) {
      final statusCode = httpResponse.statusCode;
      if (statusCode == 429) {
        final retryAfterSeconds = int.tryParse(
          httpResponse.headers['retry-after'] ?? '',
        );

        return RateLimitFailure(
          debugMessage: 'Límite de peticiones excedido (429)',
          retryAfter: retryAfterSeconds != null
              ? Duration(seconds: retryAfterSeconds)
              : null,
        );
      }

      if (statusCode >= 500 || graphqlErrors.isEmpty) {
        return ServerFailure(
          debugMessage: 'Error de servidor',
          statusCode: statusCode >= 300 ? statusCode : null,
        );
      }
    }

    if (graphqlErrors.isNotEmpty) {
      return GraphQLFailure(
        debugMessage: graphqlErrors.map((e) => e.message).join(' | '),
      );
    }

    return const ServerFailure(debugMessage: 'Error desconocido en GraphQL');
  }
}

final graphqlServiceProvider = Provider<GraphQLService>((ref) {
  return GraphQLService(
    ref.read(graphqlClientProvider),
    isOutageSimulated: () => kDebugMode && ref.read(simulateApiOutageProvider),
  );
});
