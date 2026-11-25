import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/tables/user/user_setting_table.dart';

part 'user_setting_dao.g.dart';

@DriftAccessor(tables: [UserSettingTable])
class UserSettingDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingDaoMixin {
  UserSettingDao(super.db);

  Stream<String?> watchValue(String key) {
    final query = select(userSettingTable)..where((t) => t.key.equals(key));
    return query.map((row) => row.value).watchSingleOrNull();
  }

  Future<void> saveValue(String key, String value) {
    return into(userSettingTable).insertOnConflictUpdate(
      UserSettingTableCompanion.insert(key: key, value: value),
    );
  }
}
