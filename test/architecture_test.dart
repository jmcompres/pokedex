import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('La capa de dominio no debe depender de Flutter, GraphQL ni Drift', () {
    final libDir = Directory('lib/features');

    final domainFiles = libDir
        .listSync(recursive: true)
        .whereType<File>()
        .where(
          (file) =>
              file.path.contains('/domain/') && file.path.endsWith('.dart'),
        );

    for (final file in domainFiles) {
      final content = file.readAsStringSync();

      expect(
        content.contains('package:flutter/'),
        isFalse,
        reason:
            'Error de arquitectura: ${file.path} importa Flutter. El dominio debe ser independiente de la UI.',
      );
      expect(
        content.contains('package:graphql'),
        isFalse,
        reason:
            'Error de arquitectura: ${file.path} importa GraphQL. El dominio no debe conocer detalles de la API externa.',
      );
      expect(
        content.contains('package:drift'),
        isFalse,
        reason:
            'Error de arquitectura: ${file.path} importa Drift. El dominio no debe estar atado a la base de datos local.',
      );
    }
  });
}
