import 'package:drift/drift.dart';

@DataClassName('UserSettingRow')
class UserSettingTable extends Table {
  @override
  String get tableName => 'user_setting';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
