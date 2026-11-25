import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/graphql_service.dart';

import 'pokemon_detail_dtos.dart';
import 'pokemon_queries.dart';
import 'pokemon_remote_dtos.dart';

abstract class PokemonRemoteDataSource {
  static const int defaultPageSize = 50;

  Future<ReferenceDataDto> fetchReferenceData();

  Future<List<PokemonDto>> fetchPokemonPage({
    int limit = defaultPageSize,
    required int offset,
  });

  Future<int> fetchPokemonCount();

  Future<PokemonDetailDto> fetchPokemonDetail(int pokemonId);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final GraphQLService _graphQLService;

  const PokemonRemoteDataSourceImpl(this._graphQLService);

  @override
  Future<ReferenceDataDto> fetchReferenceData() async {
    final result = await _graphQLService.performQuery(
      PokemonQueries.getReferenceData,
      operationName: PokemonQueries.getReferenceDataOp,
    );

    final data = result.data;
    if (data == null) {
      throw const ValidationFailure(
        debugMessage: 'Respuesta de referencia vacía (data == null)',
      );
    }

    return Isolate.run(() => _parseReferenceData(data));
  }

  @override
  Future<List<PokemonDto>> fetchPokemonPage({
    int limit = PokemonRemoteDataSource.defaultPageSize,
    required int offset,
  }) async {
    final result = await _graphQLService.performQuery(
      PokemonQueries.getPokemonPage,
      operationName: PokemonQueries.getPokemonPageOp,
      variables: <String, dynamic>{'limit': limit, 'offset': offset},
    );

    final rawList = result.data?['pokemon'];
    if (rawList is! List<dynamic>) {
      throw const ValidationFailure(
        debugMessage: 'Respuesta de página inválida: nodo pokemon ausente',
      );
    }

    return Isolate.run(() => _parsePokemonPage(rawList));
  }

  @override
  Future<int> fetchPokemonCount() async {
    final result = await _graphQLService.performQuery(
      PokemonQueries.getPokemonCount,
      operationName: PokemonQueries.getPokemonCountOp,
    );

    try {
      final aggregateNode =
          result.data?['pokemon_aggregate'] as Map<String, dynamic>?;
      final aggregate = aggregateNode?['aggregate'] as Map<String, dynamic>?;
      final count = (aggregate?['count'] as num?)?.toInt();

      if (count == null || count <= 0) {
        throw const ValidationFailure(
          debugMessage: 'Conteo total de Pokémon inválido o nulo',
        );
      }

      return count;
    } on Failure {
      rethrow;
    } catch (e) {
      throw ValidationFailure(
        debugMessage: 'Error al parsear conteo de Pokémon: $e',
      );
    }
  }

  @override
  Future<PokemonDetailDto> fetchPokemonDetail(int pokemonId) async {
    final result = await _graphQLService.performQuery(
      PokemonQueries.getPokemonDetail,
      operationName: PokemonQueries.getPokemonDetailOp,
      variables: <String, dynamic>{'id': pokemonId},
    );

    final rawList = result.data?['pokemon'];
    if (rawList is! List<dynamic>) {
      throw const ValidationFailure(
        debugMessage: 'Respuesta de detalle inválida: nodo pokemon ausente',
      );
    }
    if (rawList.isEmpty) {
      throw ValidationFailure(
        debugMessage: 'PokeAPI no tiene un Pokémon con id $pokemonId',
      );
    }

    final raw = rawList.first as Map<String, dynamic>;
    return Isolate.run(() => _parsePokemonDetail(raw));
  }
}

ReferenceDataDto _parseReferenceData(Map<String, dynamic> data) {
  try {
    final dto = ReferenceDataDto.fromJson(data);
    if (dto.types.isEmpty || dto.generations.isEmpty) {
      throw const ValidationFailure(
        debugMessage: 'Datos de referencia incompletos o vacíos',
      );
    }
    return dto;
  } on Failure {
    rethrow;
  } catch (e) {
    throw ValidationFailure(
      debugMessage: 'Error al parsear datos de referencia: $e',
    );
  }
}

List<PokemonDto> _parsePokemonPage(List<dynamic> rawList) {
  try {
    final dtos = rawList
        .map((e) => PokemonDto.fromJson(e as Map<String, dynamic>))
        .toList();

    PokemonDto.validatePage(dtos);

    return dtos;
  } on Failure {
    rethrow;
  } catch (e) {
    throw ValidationFailure(
      debugMessage: 'Error al parsear página de Pokémon: $e',
    );
  }
}

PokemonDetailDto _parsePokemonDetail(Map<String, dynamic> raw) {
  try {
    final dto = PokemonDetailDto.fromJson(raw);
    dto.validate();
    return dto;
  } on Failure {
    rethrow;
  } catch (e) {
    throw ValidationFailure(debugMessage: 'Error al parsear el detalle: $e');
  }
}

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  final graphQLService = ref.watch(graphqlServiceProvider);
  return PokemonRemoteDataSourceImpl(graphQLService);
});
