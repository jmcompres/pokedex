import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/settings/data/datasources/local/user_setting_dao.dart';
import 'package:pokedex/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:pokedex/features/settings/domain/entities/app_settings.dart';
import 'package:pokedex/features/settings/domain/entities/preference.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('con base en memoria', () {
    late AppDatabase db;
    late UserSettingDao dao;
    late SettingsRepositoryImpl repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      dao = UserSettingDao(db);
      repo = SettingsRepositoryImpl(dao);
    });
    tearDown(() => db.close());

    test('sin guardar nada, devuelve el valor por defecto', () async {
      expect(await repo.watch(Preferences.theme).first, AppThemeMode.system);
    });

    test('lo que se guarda con set es lo que devuelve watch', () async {
      await repo.set(Preferences.theme, AppThemeMode.dark);
      expect(await repo.watch(Preferences.theme).first, AppThemeMode.dark);
    });

    test('guardar dos veces reemplaza, no duplica', () async {
      await repo.set(Preferences.theme, AppThemeMode.dark);
      await repo.set(Preferences.theme, AppThemeMode.light);
      expect(await repo.watch(Preferences.theme).first, AppThemeMode.light);
      expect(await db.select(db.userSettingTable).get(), hasLength(1));
    });

    test('un valor que no se entiende usa el valor por defecto', () async {
      await dao.saveValue('theme', 'morado');
      expect(await repo.watch(Preferences.theme).first, AppThemeMode.system);
    });
  });

  test('una preferencia guardada sobrevive al reinicio', () async {
    final dir = await Directory.systemTemp.createTemp('pokedex_test');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/pokedex.sqlite');

    final db1 = AppDatabase(NativeDatabase(file));
    await SettingsRepositoryImpl(UserSettingDao(db1))
        .set(Preferences.theme, AppThemeMode.dark);
    await db1.close();

    final db2 = AppDatabase(NativeDatabase(file));
    addTearDown(db2.close);
    final theme = await SettingsRepositoryImpl(UserSettingDao(db2))
        .watch(Preferences.theme)
        .first;

    expect(theme, AppThemeMode.dark);
  });
}
