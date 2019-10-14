import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/matrix_cell.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/models/square_state_type.dart';
import 'package:minesweeper_online/models/square_type.dart';

class SweeperService {
  final GameOptions options;

  SweeperService({@required this.options});

  List<Square> generateBoardSquares() {
    final squares = List.generate(
      options.dimensions.rows * options.dimensions.columns,
      (index) => Square(
        cell: SweeperService.indexToCoordinates(
            index, options.dimensions.rows, options.dimensions.columns),
      ),
    );
    var randomized = List<Square>.from(squares)..shuffle();
    var selectedSquares = randomized.take(options.mines);
    var minedSquares =
        selectedSquares.map((square) => Square.setToMine(square));
    var minesSquareMap = Map<int, Square>.fromIterable(minedSquares,
        key: (square) => coordinateToIndex(square.cell));
    final finalSquares = squares
        .asMap()
        .map((index, square) => MapEntry(index,
            minesSquareMap.containsKey(index) ? minesSquareMap[index] : square))
        .values
        .toList();
    final boardSquares = finalSquares
        .map((square) => Square.setAdjacentMines(
            square, countNighboringMines(finalSquares, square)))
        .toList();
    return boardSquares;
  }

  List<Square> toggleSquare(List<Square> boardSquares, Square square) {
    final index = coordinateToIndex(square.cell);
    final newBoardSquares = List<Square>.from(boardSquares);
    final newSquare = Square.toggle(square);
    newBoardSquares[index] = newSquare;
    return newBoardSquares;
  }

  List<Square> revealMines(List<Square> boardSquares, Square trigerSquare) {
    return boardSquares.map((square) {
      Square newSquare = square;
      if (square.type == SquareType.Mine) {
        if (square.state != SquareStateType.Flagged) {
          newSquare = Square.setToOpen(newSquare);
        }
        if (trigerSquare == square) {
          newSquare = Square.setToTriggerMine(newSquare);
        }
      } else if (square.state == SquareStateType.Flagged) {
        newSquare = Square.setToWrongFlagged(newSquare);
      }
      return newSquare;
    }).toList();
  }

  bool checkWin(List<Square> boardSquares) {
    final totalSquares = options.dimensions.rows * options.dimensions.columns;
    final openedSquares = boardSquares
        .where((square) =>
            square.type == SquareType.Empty &&
            square.state == SquareStateType.Opened)
        .length;
    final squaresRemaining = totalSquares - openedSquares;
    return squaresRemaining <= options.mines;
  }

  List<Square> revealSquares(List<Square> boardSquares, Square startSquare) {
    final squareIndexMap = Map<int, Square>();
    final revealedSquares = HashSet<Square>();
    revealSquare(boardSquares, startSquare, squareIndexMap, revealedSquares);
    final newBoardSquares = List<Square>();
    boardSquares.asMap().forEach((index, square) => newBoardSquares.add(
        squareIndexMap.containsKey(index) ? squareIndexMap[index] : square));
    return newBoardSquares;
  }

  void revealSquare(List<Square> boardSquares, Square square,
      Map<int, Square> squareIndexMap, HashSet<Square> revealedSquares) {
    if (revealedSquares.contains(square)) return;
    if (!shouldRevealSquare(square)) return;

    revealedSquares.add(square);
    squareIndexMap.putIfAbsent(
        coordinateToIndex(square.cell), () => Square.setToOpen(square));

    if (shouldRevealNeighbors(square))
      findNeighbors(boardSquares, square).forEach((square) =>
          revealSquare(boardSquares, square, squareIndexMap, revealedSquares));
  }

  int countFlags(List<Square> boardSquares) {
    return boardSquares.fold(
        0,
        (sum, square) =>
            sum + (square.state == SquareStateType.Flagged ? 1 : 0));
  }

  bool shouldRevealSquare(Square square) {
    if (square.state != SquareStateType.Closed) return false;
    if (square.type == SquareType.Mine) return false;
    return true;
  }

  bool shouldRevealNeighbors(Square square) {
    return square.adjacentMines == 0;
  }

  List<Square> findNeighbors(List<Square> boardSquares, Square square) {
    final neighborPositions = [
      MatrixCell(row: square.cell.row - 1, column: square.cell.column - 1),
      MatrixCell(row: square.cell.row - 1, column: square.cell.column),
      MatrixCell(row: square.cell.row - 1, column: square.cell.column + 1),
      MatrixCell(row: square.cell.row, column: square.cell.column - 1),
      MatrixCell(row: square.cell.row, column: square.cell.column + 1),
      MatrixCell(row: square.cell.row + 1, column: square.cell.column - 1),
      MatrixCell(row: square.cell.row + 1, column: square.cell.column),
      MatrixCell(row: square.cell.row + 1, column: square.cell.column + 1),
    ];
    final validNeightbors = neighborPositions
        .where((p) => isValidMatrixCell(p))
        .map((p) => boardSquares.elementAt(coordinateToIndex(p)))
        .toList();
    return validNeightbors;
  }

  int countNighboringMines(List<Square> boardSquares, Square square,
      [List<Square> neighbors]) {
    if (neighbors == null) neighbors = findNeighbors(boardSquares, square);
    return neighbors.fold<int>(
        0, (sum, square) => sum + (square.type == SquareType.Mine ? 1 : 0));
  }

  bool isValidIndex(int index) {
    final minIndex = 0;
    final maxIndex = coordinateToIndex(MatrixCell(
        row: options.dimensions.rows, column: options.dimensions.columns));
    return index >= minIndex && index <= maxIndex;
  }

  bool isValidMatrixCell(MatrixCell cell) {
    return cell.row >= 1 &&
        cell.column >= 1 &&
        cell.row <= options.dimensions.rows &&
        cell.column <= options.dimensions.columns;
  }

  int coordinateToIndex(MatrixCell cell) {
    return ((options.dimensions.columns * (cell.row - 1)) + cell.column) - 1;
  }

  static MatrixCell indexToCoordinates(int index, int rows, int columns) {
    final column = (index % columns) + 1;
    final row = ((index + 1) / rows).ceil();
    return MatrixCell(row: row, column: column);
  }
}
