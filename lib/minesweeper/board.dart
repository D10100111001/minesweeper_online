import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/helpers/box_decoration.dart';
import 'package:minesweeper_online/minesweeper/square_tile.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/models/square_state_type.dart';
import 'package:minesweeper_online/models/square_type.dart';
import 'package:minesweeper_online/state/board_state.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';

class Board extends StatelessWidget {
  final GameManagerState gameManager;
  final BoardState boardState;
  const Board({Key key, @required this.gameManager, @required this.boardState})
      : super(key: key);

  void markSquare(Square square) {
    if (gameManager.ended) return;
    if (square.state == SquareStateType.Opened) return;
    boardState.setBoard(
        boardState.service.toggleSquare(boardState.boardSquares, square));
  }

  void openSquare(BuildContext context, Square square) {
    if (gameManager.ended) return;
    if (square.state == SquareStateType.Opened ||
        square.state == SquareStateType.Flagged ||
        square.state == SquareStateType.Marked) return;
    if (square.type == SquareType.Mine &&
        gameManager.state == GameState.NotStarted) {
      final index = boardState.service.coordinateToIndex(square.cell);
      final boardSquares =
          boardState.service.moveMine(boardState.boardSquares, square);
      boardState.setBoard(boardSquares);
      square = boardSquares[index];
    }
    if (square.type == SquareType.Mine) {
      //if (kDebugMode) return;
      revealMine(context, square);
    } else {
      revealSquare(context, square);
    }
  }

  void revealMine(BuildContext context, Square square) {
    if (!gameManager.ended) gameManager.endGame(false);
    boardState.setBoard(
        boardState.service.revealMines(boardState.boardSquares, square));
    showMessage(context, false);
  }

  void revealSquare(BuildContext context, Square square) {
    if (gameManager.state == GameState.NotStarted) gameManager.startGame();
    boardState.setBoard(
        boardState.service.revealSquares(boardState.boardSquares, square));
    if (boardState.service.checkWin(boardState.boardSquares)) {
      if (!gameManager.ended) gameManager.endGame(true);
      showMessage(context, true);
    }
  }

  void showMessage(BuildContext context, [bool win = false]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(win ? "Congratulations!" : "Game Over!"),
          content: Text(win ? "You Win!" : "You stepped on a mine!"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                gameManager.restartGame();
                Navigator.pop(context);
              },
              child: Text("Play again"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecorationHelper.buildMinesweeperDecoration(
          themeData.toggleButtonsTheme, true),
      margin: const EdgeInsets.all(10.0),
      child: GridView.count(
        shrinkWrap: true,
        primary: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0.0),
        crossAxisCount: gameManager.options.dimensions.columns,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
        children: List.generate(
          gameManager.options.dimensions.rows *
              gameManager.options.dimensions.columns,
          (index) {
            final square = boardState.boardSquares.elementAt(index);
            return SquareTile(
              square: square,
              onMark: () => markSquare(square),
              onOpen: () => openSquare(context, square),
            );
          },
        ),
      ),
    );
  }
}
