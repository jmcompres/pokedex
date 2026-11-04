import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import '../errors/failures.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink('https://graphql.pokeapi.co/v1beta2');

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.noCache
      )
    )
  );
});


class GraphQLService {
  final GraphQLClient _client;
  static const _timeout = Duration(seconds: 15);

  GraphQLService(this._client);

  Future<QueryResult> performQuery(String query, {Map<String, dynamic> variables = const {}}) async{
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    try{
      final QueryResult result = await _client.query(options).timeout(_timeout);
      if (result.hasException){
        throw _mapGraphQLException(result.exception!);
      }
      return result;

    } on TimeoutException{
      throw const TimeoutFailure(debugMessage: 'La petición superó los 15 segundos');
    } on SocketException{
      throw const NetworkFailure(debugMessage: 'No hay conexión a Internet');
    } on Failure{
      rethrow;
    } catch(e){
      throw ServerFailure(debugMessage: 'Error inesperado: $e');
    }
  }

  Failure _mapGraphQLException(OperationException ex){
    if (ex.linkException != null){
      final linkException = ex.linkException!;

      if (linkException is NetworkException){
        return const NetworkFailure(debugMessage: 'Error de red en el Link de GraphQL');
      }

      if (linkException is HttpLinkServerException){
        if (linkException.response.statusCode == 429){
          return const RateLimitFailure(debugMessage: 'Límite de peticiones excedido (429)');
        }
        return ServerFailure(
          debugMessage: 'Error de servidor',
          statusCode: linkException.response.statusCode,
        );
      }
    }

    if (ex.graphqlErrors.isNotEmpty){
      return GraphQLFailure(debugMessage: 'Error de GraphQL: ${ex.graphqlErrors.first.message}');
    }

    return const ServerFailure(debugMessage: 'Error desconocido en GraphQL');
  }
}

final graphqlServiceProvider = Provider<GraphQLService>((ref) {
  return GraphQLService(ref.read(graphqlClientProvider));
});