import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/network/graphql_service.dart';

GraphQLService _buildServiceWithLink(Link link) {
  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: link,
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
    ),
  );
  return GraphQLService(client);
}

Future<HttpServer> _startMockServer(
  void Function(HttpResponse response) handler,
) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  addTearDown(() => server.close(force: true));
  server.listen((request) async {
    await request.drain<void>();
    handler(request.response);
    await request.response.close();
  });
  return server;
}

const _sampleQuery = '''
  query TestQuery {
    pokemon {
      id
      name
    }
  }
''';

void main() {
  group('GraphQLService.performQuery', () {
    test(
      'retorna QueryResult cuando la respuesta es exitosa sin errores',
      () async {
        final link = Link.function(
          (request, [forward]) => Stream.value(
            const Response(
              response: <String, dynamic>{},
              data: <String, dynamic>{
                'pokemon': <Map<String, dynamic>>[
                  <String, dynamic>{'id': 1, 'name': 'bulbasaur'},
                ],
              },
            ),
          ),
        );
        final service = _buildServiceWithLink(link);

        final result = await service.performQuery(
          _sampleQuery,
          operationName: 'TestQuery',
        );

        expect(result.hasException, isFalse);
        expect(result.data?['pokemon'], hasLength(1));
      },
    );

    test(
      'trata respuesta parcial (data + errors) como GraphQLFailure (OF-04)',
      () async {
        final link = Link.function(
          (request, [forward]) => Stream.value(
            const Response(
              response: <String, dynamic>{},
              data: <String, dynamic>{
                'pokemon': <Map<String, dynamic>>[
                  <String, dynamic>{'id': 1, 'name': 'bulbasaur'},
                ],
              },
              errors: <GraphQLError>[
                GraphQLError(message: 'Error parcial en campo species'),
              ],
            ),
          ),
        );
        final service = _buildServiceWithLink(link);

        await expectLater(
          service.performQuery(_sampleQuery, operationName: 'TestQuery'),
          throwsA(
            isA<GraphQLFailure>().having(
              (f) => f.debugMessage,
              'debugMessage',
              contains('Error parcial en campo species'),
            ),
          ),
        );
      },
    );

    test(
      'lanza NetworkFailure ante SocketException y NetworkException',
      () async {
        final socketLink = Link.function(
          (request, [forward]) =>
              Stream<Response>.error(const SocketException('Sin conexión')),
        );
        final networkLink = Link.function(
          (request, [forward]) => Stream<Response>.error(
            NetworkException.fromException(
              originalException: const SocketException('Fallo de enlace'),
              originalStackTrace: StackTrace.empty,
              message: 'Fallo de enlace',
              uri: Uri.parse('https://graphql.pokeapi.co/v1beta2'),
            ),
          ),
        );

        await expectLater(
          _buildServiceWithLink(socketLink)
              .performQuery(_sampleQuery, operationName: 'TestQuery'),
          throwsA(isA<NetworkFailure>()),
        );
        await expectLater(
          _buildServiceWithLink(networkLink)
              .performQuery(_sampleQuery, operationName: 'TestQuery'),
          throwsA(isA<NetworkFailure>()),
        );
      },
    );

    test('lanza TimeoutFailure cuando la petición supera el timeout', () async {
      final slowLink = Link.function(
        (request, [forward]) => Stream<Response>.fromFuture(
          Future<Response>.delayed(
            const Duration(milliseconds: 200),
            () => const Response(
              response: <String, dynamic>{},
              data: <String, dynamic>{},
            ),
          ),
        ),
      );
      final service = _buildServiceWithLink(slowLink);

      await expectLater(
        service.performQuery(
          _sampleQuery,
          operationName: 'TestQuery',
          timeout: const Duration(milliseconds: 20),
        ),
        throwsA(isA<TimeoutFailure>()),
      );
    });
  });

  group('GraphQLService con HttpLink real (RNF-RES-05, OF-04)', () {
    test('rechaza HTTP 200 con data + errors como GraphQLFailure', () async {
      final server = await _startMockServer((res) {
        res.statusCode = HttpStatus.ok;
        res.headers.contentType = ContentType.json;
        res.write(
          jsonEncode(<String, dynamic>{
            'data': <String, dynamic>{
              'pokemon': <Map<String, dynamic>>[
                <String, dynamic>{'id': 25, 'name': 'pikachu'},
              ],
            },
            'errors': <Map<String, dynamic>>[
              <String, dynamic>{'message': 'Fallo parcial desde servidor'},
            ],
          }),
        );
      });

      final service = _buildServiceWithLink(
        HttpLink('http://127.0.0.1:${server.port}'),
      );

      await expectLater(
        service.performQuery(_sampleQuery, operationName: 'TestQuery'),
        throwsA(
          isA<GraphQLFailure>().having(
            (f) => f.debugMessage,
            'debugMessage',
            contains('Fallo parcial desde servidor'),
          ),
        ),
      );
    });

    test('mapea HTTP 429 con Retry-After a RateLimitFailure', () async {
      final server = await _startMockServer((res) {
        res.statusCode = HttpStatus.tooManyRequests;
        res.headers.set('retry-after', '30');
        res.headers.contentType = ContentType.json;
        res.write(jsonEncode(<String, dynamic>{'error': 'rate limited'}));
      });

      final service = _buildServiceWithLink(
        HttpLink('http://127.0.0.1:${server.port}'),
      );

      await expectLater(
        service.performQuery(_sampleQuery, operationName: 'TestQuery'),
        throwsA(
          isA<RateLimitFailure>().having(
            (f) => f.retryAfter,
            'retryAfter',
            const Duration(seconds: 30),
          ),
        ),
      );
    });

    test(
      'mapea HTTP 503 y 404 sin errores GraphQL a ServerFailure con statusCode',
      () async {
        var nextStatus = HttpStatus.serviceUnavailable;
        final server = await _startMockServer((res) {
          res.statusCode = nextStatus;
          res.write('error');
        });
        final service = _buildServiceWithLink(
          HttpLink('http://127.0.0.1:${server.port}'),
        );

        await expectLater(
          service.performQuery(_sampleQuery, operationName: 'TestQuery'),
          throwsA(
            isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 503),
          ),
        );

        nextStatus = HttpStatus.notFound;
        await expectLater(
          service.performQuery(_sampleQuery, operationName: 'TestQuery'),
          throwsA(
            isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 404),
          ),
        );
      },
    );

    test(
      'prioriza GraphQLFailure en HTTP 400 cuando incluye errores GraphQL',
      () async {
        final server = await _startMockServer((res) {
          res.statusCode = HttpStatus.badRequest;
          res.headers.contentType = ContentType.json;
          res.write(
            jsonEncode(<String, dynamic>{
              'errors': <Map<String, dynamic>>[
                <String, dynamic>{'message': 'Campo inexistente en consulta'},
              ],
            }),
          );
        });

        final service = _buildServiceWithLink(
          HttpLink('http://127.0.0.1:${server.port}'),
        );

        await expectLater(
          service.performQuery(_sampleQuery, operationName: 'TestQuery'),
          throwsA(
            isA<GraphQLFailure>().having(
              (f) => f.debugMessage,
              'debugMessage',
              contains('Campo inexistente en consulta'),
            ),
          ),
        );
      },
    );
  });
}
