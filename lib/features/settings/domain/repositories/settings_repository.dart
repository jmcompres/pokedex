import '../entities/preference.dart';

abstract interface class SettingsRepository {
  Stream<T> watch<T>(Preference<T> preference);
  Future<void> set<T>(Preference<T> preference, T value);
}