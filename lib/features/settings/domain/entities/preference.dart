import 'package:pokedex/features/settings/domain/entities/app_settings.dart';

class Preference<T> {
  const Preference({
    required this.key,
    required this.defaultValue,
    required this.encode,
    required this.decode,
  });

  final String key;
  final T defaultValue;
  final String Function(T value) encode;
  final T? Function(String raw) decode;

  static Preference<E> ofEnum<E extends Enum>(
    String key,
    List<E> values,
    E defaultValue,
  ) {
    return Preference(
      key: key,
      defaultValue: defaultValue,
      encode: (value) => value.name,
      decode: (raw) => values.asNameMap()[raw],
    );
  }
}

abstract final class Preferences {
  static final theme = Preference.ofEnum(
    'theme',
    AppThemeMode.values,
    AppThemeMode.system,
  );
  static final language = Preference.ofEnum(
    'language',
    AppLanguage.values,
    AppLanguage.system,
  );
}
