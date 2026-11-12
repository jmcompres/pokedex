import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

List<File> archivosDeCapa(String capa) =>
    Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart') && !f.path.endsWith('.g.dart'))
        .where((f) => f.uri.pathSegments.contains(capa))
        .toList();

List<String> importsDe(File archivo) => archivo
    .readAsLinesSync()
    .map((linea) => linea.trim())
    .where((l) => l.startsWith('import ') || l.startsWith('export '))
    .toList();

void verificarCapa(String capa, List<String> prohibidos) {
  final violaciones = <String>[
    for (final archivo in archivosDeCapa(capa))
      for (final linea in importsDe(archivo))
        if (prohibidos.any(linea.contains)) '${archivo.path}: $linea',
  ];

  expect(
    violaciones,
    isEmpty,
    reason: 'La capa "$capa" importa algo que no debe',
  );
}

void main() {
  test('domain no depende de Flutter, Drift, GraphQL ni de la capa data', () {
    verificarCapa('domain', [
      'package:flutter',
      'package:drift',
      'package:graphql',
      'package:ferry',
      'app_database',
      '/data/',
    ]);
  });

  test('presentation no accede a la base, a GraphQL ni a DTOs', () {
    verificarCapa('presentation', [
      'package:drift',
      'package:graphql',
      'package:ferry',
      'app_database',
      '/datasources/',
      '/mappers/',
      '_dto',
    ]);
  });
}
