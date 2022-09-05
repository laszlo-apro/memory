import 'dart:async';

import 'package:collection/collection.dart';
import 'package:memory/src/game_internals/level_state.dart';
import 'package:memory/src/level_selection/cards.dart';

class GameState {
  GameState({
    required this.numRows,
    required this.numColumns,
    required this.levelState,
  });

  final int numRows;
  final int numColumns;
  final LevelState levelState;

  late List<CardState> _cardStates;

  final evaluationResultStreamController =
      StreamController<EvaluationResult>.broadcast();

  void init(List<GameCard> cards) {
    _cardStates = cards
        .mapIndexed((index, card) => CardState(
              card: card,
              rowIndex: index ~/ numColumns,
              columnIndex: index % numColumns,
              shown: false,
            ))
        .toList();
  }

  CardState getCardStateAt(int rowIndex, int columnIndex) =>
      _cardStates[rowIndex * numColumns + columnIndex];

  void setCardStateAsShownAt(int rowIndex, int columnIndex) {
    final state = _cardStates[rowIndex * numColumns + columnIndex];
    _cardStates[rowIndex * numColumns + columnIndex] =
        state.copyWith(shown: true);
  }

  void evaluate() {
    if (twoCardsShown) {
      final candidatePair = shownCards;
      final first = candidatePair[0];
      final second = candidatePair[1];
      bool match = first.card.imagePath == second.card.imagePath;

      _cardStates[first.rowIndex * numColumns + first.columnIndex] =
          first.copyWith(shown: match ? null : false);
      _cardStates[second.rowIndex * numColumns + second.columnIndex] =
          second.copyWith(shown: match ? null : false);

      evaluationResultStreamController.add(EvaluationResult(
        firstRowIndex: first.rowIndex,
        firstColumnIndex: first.columnIndex,
        secondRowIndex: second.rowIndex,
        secondColumnIndex: second.columnIndex,
      ));

      if (match) {
        levelState.setProgress(levelState.progress + 1);
        levelState.evaluate();
      }
    }
  }

  bool get shouldShow => noCardsShown || oneCardShown;

  bool get noCardsShown => shownCardCount == 0;

  bool get oneCardShown => shownCardCount == 1;

  bool get twoCardsShown => shownCardCount == 2;

  int get shownCardCount => shownCards.length;

  List<CardState> get shownCards =>
      _cardStates.where((state) => state.shown == true).toList();
}

class CardState {
  const CardState({
    required this.card,
    required this.rowIndex,
    required this.columnIndex,
    required this.shown,
  });

  final GameCard card;
  final int rowIndex;
  final int columnIndex;
  final bool? shown;

  CardState copyWith({bool? shown}) => CardState(
        card: card,
        rowIndex: rowIndex,
        columnIndex: columnIndex,
        shown: shown,
      );
}

class EvaluationResult {
  const EvaluationResult({
    required this.firstRowIndex,
    required this.firstColumnIndex,
    required this.secondRowIndex,
    required this.secondColumnIndex,
  });

  final int firstRowIndex;
  final int firstColumnIndex;
  final int secondRowIndex;
  final int secondColumnIndex;
}
