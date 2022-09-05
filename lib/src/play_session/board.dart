import 'package:flutter/material.dart';
import 'package:memory/src/game_internals/level_state.dart';
import 'package:memory/src/level_selection/cards.dart';
import 'package:memory/src/play_session/game_state.dart';
import 'package:memory/src/play_session/memory_card.dart';

class Board extends StatefulWidget {
  const Board({
    Key? key,
    required this.cards,
    required this.numRows,
    required this.numColumns,
    required this.levelState,
  }) : super(key: key);

  final List<GameCard> cards;
  final int numRows;
  final int numColumns;
  final LevelState levelState;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late GameState _gameState;

  @override
  void initState() {
    super.initState();

    _gameState = GameState(
      numRows: widget.numRows,
      numColumns: widget.numColumns,
      levelState: widget.levelState,
    );
    _gameState.init(widget.cards);
  }

  @override
  Widget build(BuildContext context) {
    final boardHeight = MediaQuery.of(context).size.height * 0.8;
    final fieldSize = boardHeight / widget.numRows;
    final boardWidth = fieldSize * widget.numColumns;

    return SizedBox(
      width: boardWidth,
      height: boardHeight,
      child: Column(
        children: List.generate(
          widget.numRows,
          (rowIndex) => Row(
            children: List.generate(
              widget.numColumns,
              (columnIndex) => MemoryCard(
                size: fieldSize,
                rowIndex: rowIndex,
                columnIndex: columnIndex,
                gameState: _gameState,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
