import 'package:pokedex/features/settings/data/datasources/local/user_setting_dao.dart';
import 'package:pokedex/features/settings/domain/entities/preference.dart';
import 'package:pokedex/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._dao);

  final UserSettingDao _dao;

  @override
  Stream<T> watch<T>(Preference<T> preference) {
    return _dao.watchValue(preference.key).map((raw) {
      if (raw == null) return preference.defaultValue;
      return preference.decode(raw) ?? preference.defaultValue;
    }).distinct();
  }

  @override
  Future<void> set<T>(Preference<T> preference, T value) {
    return _dao.saveValue(preference.key, preference.encode(value));
  }
}
