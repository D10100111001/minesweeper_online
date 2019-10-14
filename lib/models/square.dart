import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_online/models/matrix_cell.dart';
import 'package:minesweeper_online/models/square_state_type.dart';
import 'package:minesweeper_online/models/square_type.dart';

@immutable
class Square {
  final MatrixCell cell;
  final SquareType type;
  final SquareStateType state;
  final int adjacentMines;
  Square(
      {@required this.cell,
      this.type = SquareType.Empty,
      this.state = SquareStateType.Closed,
      this.adjacentMines = 0});

  factory Square.setToMine(Square square) {
    return Square(
      cell: square.cell,
      type: SquareType.Mine,
      state: square.state,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setToTriggerMine(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: SquareStateType.TriggerMine,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setToClosed(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: SquareStateType.Closed,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setToFlagged(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: SquareStateType.Flagged,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setToWrongFlagged(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: SquareStateType.WrongFlagged,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setToMarked(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: SquareStateType.Marked,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.toggle(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: square.state == SquareStateType.Closed
          ? SquareStateType.Flagged
          : square.state == SquareStateType.Flagged
              ? SquareStateType.Marked
              : SquareStateType.Closed,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setToOpen(Square square) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: SquareStateType.Opened,
      adjacentMines: square.adjacentMines,
    );
  }

  factory Square.setAdjacentMines(Square square, int adjacentMines) {
    return Square(
      cell: square.cell,
      type: square.type,
      state: square.state,
      adjacentMines: adjacentMines,
    );
  }

  static final colorMap = {
    0: Colors.transparent,
    1: const Color(0xFF0000FF),
    2: const Color(0xFF008200),
    3: const Color(0xFFFF0000),
    4: const Color(0xFF000084),
    5: const Color(0xFF840000),
    6: const Color(0xFF008284),
    7: const Color(0xFF840084),
    8: const Color(0xFF757575),
  };

  Color get color => colorMap.containsKey(adjacentMines)
      ? colorMap[adjacentMines]
      : Colors.white;
}
