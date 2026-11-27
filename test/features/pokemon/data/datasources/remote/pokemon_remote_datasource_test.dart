import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/graphql_service.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_queries.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_remote_mappers.dart';

class FakeGraphQLService implements GraphQLService {
  Map<String, dynamic>? nextData;
  Failure? nextFailure;

  String? lastQuery;
  String? lastOperationName;
  Map<String, dynamic>? lastVariables;

  @override
  bool Function()? get isOutageSimulated => null;

  @override
  Future<QueryResult<Object?>> performQuery(
    String query, {
    required String operationName,
    Map<String, dynamic> variables = const {},
    Duration timeout = const Duration(seconds: 15),
  }) async {
    lastQuery = query;
    lastOperationName = operationName;
    lastVariables = variables;

    if (nextFailure != null) {
      throw nextFailure!;
    }

    return QueryResult(
      options: QueryOptions(
        document: gql(query),
        operationName: operationName,
        variables: variables,
      ),
      data: nextData,
      source: QueryResultSource.network,
    );
  }
}

void main() {
  late FakeGraphQLService fakeGraphQLService;
  late PokemonRemoteDataSourceImpl dataSource;

  setUp(() {
    fakeGraphQLService = FakeGraphQLService();
    dataSource = PokemonRemoteDataSourceImpl(fakeGraphQLService);
  });

  Map<String, dynamic> buildValidReferenceJson() {
    return <String, dynamic>{
      'type': [
        <String, dynamic>{
          'id': 12,
          'name': 'grass',
          'typenames': [
            <String, dynamic>{'name': 'Planta'},
          ],
        },
      ],
      'typeefficacy': [
        <String, dynamic>{
          'damage_type_id': 10,
          'target_type_id': 12,
          'damage_factor': 200,
        },
      ],
      'generation': [
        <String, dynamic>{
          'id': 1,
          'name': 'generation-i',
          'region': <String, dynamic>{'name': 'kanto'},
        },
      ],
      'versiongroup': [
        <String, dynamic>{
          'id': 1,
          'name': 'red-blue',
          'generation_id': 1,
          'order': 1,
        },
      ],
      'egggroup': [
        <String, dynamic>{
          'id': 1,
          'name': 'monster',
          'egggroupnames': [
            <String, dynamic>{'name': 'Monstruo'},
          ],
        },
      ],
    };
  }

  List<Map<String, dynamic>> buildValidStats() {
    return [
      <String, dynamic>{
        'base_stat': 45,
        'stat': <String, dynamic>{'name': 'hp'},
      },
      <String, dynamic>{
        'base_stat': 49,
        'stat': <String, dynamic>{'name': 'attack'},
      },
      <String, dynamic>{
        'base_stat': 49,
        'stat': <String, dynamic>{'name': 'defense'},
      },
      <String, dynamic>{
        'base_stat': 65,
        'stat': <String, dynamic>{'name': 'special-attack'},
      },
      <String, dynamic>{
        'base_stat': 65,
        'stat': <String, dynamic>{'name': 'special-defense'},
      },
      <String, dynamic>{
        'base_stat': 45,
        'stat': <String, dynamic>{'name': 'speed'},
      },
    ];
  }

  Map<String, dynamic> buildValidPokemonJson({
    int id = 1,
    String name = 'bulbasaur',
    bool isDefault = true,
    Map<String, dynamic>? species,
    bool nullSpecies = false,
    List<Map<String, dynamic>>? types,
    List<Map<String, dynamic>>? stats,
    Object? rawSpritesOverride,
  }) {
    final defaultSpritesMap = <String, dynamic>{
      'front_default': 'https://raw.githubusercontent.com/sprites/$id.png',
      'front_shiny': 'https://raw.githubusercontent.com/sprites/shiny/$id.png',
      'other': <String, dynamic>{
        'official-artwork': <String, dynamic>{
          'front_default': 'https://raw.githubusercontent.com/artwork/$id.png',
          'front_shiny':
              'https://raw.githubusercontent.com/artwork/shiny/$id.png',
        },
      },
    };

    return <String, dynamic>{
      'id': id,
      'name': name,
      'is_default': isDefault,
      'height': 7,
      'weight': 69,
      'pokemonspecy': nullSpecies
          ? null
          : (species ??
                <String, dynamic>{
                  'id': 1,
                  'name': 'bulbasaur',
                  'generation_id': 1,
                  'evolution_chain_id': 1,
                }),
      'pokemonforms': [
        <String, dynamic>{
          'id': id,
          'name': name,
          'form_name': isDefault ? '' : 'mega',
          'is_default': isDefault,
          'is_mega': !isDefault,
          'is_battle_only': !isDefault,
          'form_order': 1,
        },
      ],
      'pokemontypes':
          types ??
          [
            <String, dynamic>{'slot': 1, 'type_id': 12},
            <String, dynamic>{'slot': 2, 'type_id': 4},
          ],
      'pokemonstats': stats ?? buildValidStats(),
      'pokemonsprites': [
        <String, dynamic>{'sprites': rawSpritesOverride ?? defaultSpritesMap},
      ],
    };
  }

  // ==========================================================================
  // 1. Pruebas de fetchReferenceData y Mappers de Referencia
  // ==========================================================================

  group('fetchReferenceData & ReferenceDataDtoMapper', () {
    test(
      'parsea ReferenceDataDto correctamente y lo mapea a ReferenceData local',
      () async {
        fakeGraphQLService.nextData = buildValidReferenceJson();

        final dto = await dataSource.fetchReferenceData();

        expect(
          fakeGraphQLService.lastOperationName,
          PokemonQueries.getReferenceDataOp,
        );
        expect(dto.types.length, 1);
        expect(dto.types.first.name, 'grass');
        expect(dto.types.first.nameEs, 'Planta');
        expect(dto.generations.first.regionName, 'kanto');
        expect(dto.eggGroups.first.nameEs, 'Monstruo');

        final local = dto.toLocal();
        expect(local.types.first.id.value, 12);
        expect(local.types.first.nameEs.value, 'Planta');
        expect(local.typeEfficacy.first.attackingTypeId.value, 10);
        expect(local.typeEfficacy.first.defendingTypeId.value, 12);
        expect(local.typeEfficacy.first.damageFactor.value, 200);
        expect(local.generations.first.mainRegion.value, 'kanto');
        expect(local.versionGroups.first.sortOrder.value, 1);
      },
    );

    test('lanza ValidationFailure si data es null o las listas críticas vienen vacías', () async {
      fakeGraphQLService.nextData = <String, dynamic>{
        'type': <dynamic>[],
        'generation': <dynamic>[],
      };

      expect(
        () => dataSource.fetchReferenceData(),
        throwsA(isA<ValidationFailure>()),
      );
    });
  });

  // ==========================================================================
  // 2. Pruebas de fetchPokemonPage, Sprites (Punto 7) y Mappers de Catálogo
  // ==========================================================================

  group('fetchPokemonPage & PokemonPageMapper', () {
    test('envía limit=50 por defecto, extrae los 4 sprites y mapea a CatalogPage deduplicando especies', () async {
      final bulbasaurJson = buildValidPokemonJson(id: 1, name: 'bulbasaur');
      // Simulamos una forma adicional que comparte la misma especie (id: 1)
      // y cuyos sprites vienen serializados como String JSON
      final venusaurMegaJson = buildValidPokemonJson(
        id: 10033,
        name: 'venusaur-mega',
        isDefault: false,
        rawSpritesOverride: jsonEncode(<String, dynamic>{
          'front_default':
              'https://raw.githubusercontent.com/sprites/10033.png',
          'front_shiny':
              'https://raw.githubusercontent.com/sprites/shiny/10033.png',
          'other': <String, dynamic>{
            'official-artwork': <String, dynamic>{
              'front_default':
                  'https://raw.githubusercontent.com/artwork/10033.png',
              'front_shiny':
                  'https://raw.githubusercontent.com/artwork/shiny/10033.png',
            },
          },
        }),
      );

      fakeGraphQLService.nextData = <String, dynamic>{
        'pokemon': [bulbasaurJson, venusaurMegaJson],
      };

      final dtos = await dataSource.fetchPokemonPage(offset: 0);

      expect(
        fakeGraphQLService.lastOperationName,
        PokemonQueries.getPokemonPageOp,
      );
      expect(fakeGraphQLService.lastVariables, <String, dynamic>{
        'limit': 50,
        'offset': 0,
      });

      expect(dtos.length, 2);
      // form_name vacío "" debe normalizarse a null
      expect(dtos.first.formName, isNull);
      expect(dtos.last.formName, 'mega');

      // Verificación de las 4 URLs de sprites (Punto 7)
      expect(
        dtos.first.sprites.spriteUrl,
        'https://raw.githubusercontent.com/sprites/1.png',
      );
      expect(
        dtos.first.sprites.spriteShinyUrl,
        'https://raw.githubusercontent.com/sprites/shiny/1.png',
      );
      expect(
        dtos.first.sprites.artworkUrl,
        'https://raw.githubusercontent.com/artwork/1.png',
      );
      expect(
        dtos.first.sprites.artworkShinyUrl,
        'https://raw.githubusercontent.com/artwork/shiny/1.png',
      );

      // Verificación del mapper a CatalogPage y deduplicación de especie
      final fixedDate = DateTime.utc(2026, 1, 1);
      final catalogPage = dtos.toCatalogPage(updatedAt: fixedDate);

      expect(catalogPage.species.length, 1); // Ambos compartían species.id = 1
      expect(catalogPage.pokemon.length, 2);
      expect(catalogPage.pokemon.first.hp.value, 45);
      expect(catalogPage.pokemon.first.specialAttack.value, 65);
      expect(catalogPage.pokemon.first.updatedAt.value, fixedDate);
      expect(catalogPage.pokemonTypes.length, 4); // 2 tipos por cada Pokémon
      expect(catalogPage.forms.length, 2);
      expect(catalogPage.formTypes.length, 4);
    });
  });

  // ==========================================================================
  // 3. Pruebas de Validación de Integridad de Página (Punto 8 / OF-04)
  // ==========================================================================

  group('Validaciones de integridad de página (OF-04)', () {
    test('rechaza la página con ValidationFailure si el ID es <= 0', () async {
      fakeGraphQLService.nextData = <String, dynamic>{
        'pokemon': [buildValidPokemonJson(id: 0)],
      };

      expect(
        () => dataSource.fetchPokemonPage(offset: 0),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test(
      'rechaza la página con ValidationFailure si no tiene especie válida',
      () async {
        fakeGraphQLService.nextData = <String, dynamic>{
          'pokemon': [buildValidPokemonJson(nullSpecies: true)],
        };

        expect(
          () => dataSource.fetchPokemonPage(offset: 0),
          throwsA(isA<ValidationFailure>()),
        );
      },
    );

    test(
      'rechaza la página con ValidationFailure si la lista de tipos está vacía',
      () async {
        fakeGraphQLService.nextData = <String, dynamic>{
          'pokemon': [buildValidPokemonJson(types: [])],
        };

        expect(
          () => dataSource.fetchPokemonPage(offset: 0),
          throwsA(isA<ValidationFailure>()),
        );
      },
    );

    test(
      'rechaza la página con ValidationFailure si tiene menos de 6 stats',
      () async {
        final incompleteStats = buildValidStats()..removeLast();
        fakeGraphQLService.nextData = <String, dynamic>{
          'pokemon': [buildValidPokemonJson(stats: incompleteStats)],
        };

        expect(
          () => dataSource.fetchPokemonPage(offset: 0),
          throwsA(isA<ValidationFailure>()),
        );
      },
    );

    test('rechaza la página con ValidationFailure si tiene 6 stats pero falta uno requerido', () async {
      final duplicatedStats = buildValidStats();
      // Reemplazamos 'speed' por otro 'hp'
      duplicatedStats[5] = <String, dynamic>{
        'base_stat': 50,
        'stat': <String, dynamic>{'name': 'hp'},
      };

      fakeGraphQLService.nextData = <String, dynamic>{
        'pokemon': [buildValidPokemonJson(stats: duplicatedStats)],
      };

      expect(
        () => dataSource.fetchPokemonPage(offset: 0),
        throwsA(isA<ValidationFailure>()),
      );
    });
  });

  // ==========================================================================
  // 4. Pruebas de fetchPokemonCount y propagación de Failures de red
  // ==========================================================================

  group('fetchPokemonCount & Propagación de Errores', () {
    test('retorna el conteo total de registros cuando es válido', () async {
      fakeGraphQLService.nextData = <String, dynamic>{
        'pokemon_aggregate': <String, dynamic>{
          'aggregate': <String, dynamic>{'count': 1302},
        },
      };

      final count = await dataSource.fetchPokemonCount();

      expect(
        fakeGraphQLService.lastOperationName,
        PokemonQueries.getPokemonCountOp,
      );
      expect(count, 1302);
    });

    test('lanza ValidationFailure si el conteo es <= 0 o nulo', () async {
      fakeGraphQLService.nextData = <String, dynamic>{
        'pokemon_aggregate': <String, dynamic>{
          'aggregate': <String, dynamic>{'count': 0},
        },
      };

      expect(
        () => dataSource.fetchPokemonCount(),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test(
      'propaga intacto un NetworkFailure o TimeoutFailure sin envolverlo',
      () async {
        fakeGraphQLService.nextFailure = const NetworkFailure(
          debugMessage: 'Sin conexión',
        );

        expect(
          () => dataSource.fetchPokemonPage(offset: 0),
          throwsA(isA<NetworkFailure>()),
        );
      },
    );
  });
}
