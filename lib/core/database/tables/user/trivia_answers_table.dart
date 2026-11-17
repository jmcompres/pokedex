import 'package:drift/drift.dart';

import 'trivia_results_table.dart';

@DataClassName('TriviaAnswerRow')
class TriviaAnswersTable extends Table {
  @override
  String get tableName => 'trivia_answer';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get triviaResultId => integer().references(
    TriviaResultsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  // Sin FK porque es un registro histórico de la partida y no debe impedir operaciones sobre el catálogo
  IntColumn get pokemonId => integer()();
  BoolColumn get correct => boolean()();
}
