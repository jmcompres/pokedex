// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('v1 → v2 conserva el catálogo y los favoritos', () async {
    final schema = await verifier.schemaAt(1);

    final raw = schema.rawDatabase;
    raw.execute("INSERT INTO generation (id, name) VALUES (1, 'generation-i')");
    raw.execute(
      'INSERT INTO species (id, name, generation_id, evolution_chain_id) '
      "VALUES (25, 'pikachu', 1, 10)",
    );
    raw.execute(
      'INSERT INTO pokemon (id, species_id, name, is_default, hp, attack, '
      'defense, special_attack, special_defense, speed, updated_at) '
      "VALUES (25, 25, 'pikachu', 1, 35, 55, 40, 50, 50, 90, 0)",
    );
    raw.execute('INSERT INTO favorite (pokemon_id) VALUES (25)');

    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 2);

    final pokemon = await db.select(db.pokemonTable).get();
    expect(pokemon.single.name, 'pikachu');

    final favoritos = await db.select(db.favoritesTable).get();
    expect(favoritos.single.pokemonId, 25);

    expect(await db.select(db.userSettingTable).get(), isEmpty);

    await db.close();
  });
}
