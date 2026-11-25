import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/database/database_providers.dart';
import 'package:pokedex/features/settings/data/datasources/local/user_setting_dao.dart';
import 'package:pokedex/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:pokedex/features/settings/domain/repositories/settings_repository.dart';

final userSettingDaoProvider = Provider<UserSettingDao>((ref) {
  return UserSettingDao(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(userSettingDaoProvider));
});
