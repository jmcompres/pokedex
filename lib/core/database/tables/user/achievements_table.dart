import 'package:drift/drift.dart';

@DataClassName('AchievementRow')
class AchievementsTable extends Table {
  @override
  String get tableName => 'achievement_unlocked';

  TextColumn get achievementKey => text()();
  DateTimeColumn get unlockedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {achievementKey};
}
