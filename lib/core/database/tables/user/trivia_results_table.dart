import 'package:drift/drift.dart';

@DataClassName('TriviaResultRow')
class TriviaResultsTable extends Table {
  @override
  String get tableName => 'trivia_result';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer()();
  IntColumn get correctAnswers => integer()();
  IntColumn get totalQuestions => integer()();
  DateTimeColumn get playedAt => dateTime()();
}