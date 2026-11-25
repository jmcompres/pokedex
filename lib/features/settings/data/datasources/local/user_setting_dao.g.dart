// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_setting_dao.dart';

// ignore_for_file: type=lint
mixin _$UserSettingDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserSettingTableTable get userSettingTable =>
      attachedDatabase.userSettingTable;
  UserSettingDaoManager get managers => UserSettingDaoManager(this);
}

class UserSettingDaoManager {
  final _$UserSettingDaoMixin _db;
  UserSettingDaoManager(this._db);
  $$UserSettingTableTableTableManager get userSettingTable =>
      $$UserSettingTableTableTableManager(
        _db.attachedDatabase,
        _db.userSettingTable,
      );
}
