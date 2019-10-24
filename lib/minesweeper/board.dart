import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/helpers/box_decoration.dart';
import 'package:minesweeper_online/minesweeper/square_tile.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/models/square_state_type.dart';
import 'package:minesweeper_online/models/square_type.dart';
import 'package:minesweeper_online/services/audio_service.dart';
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
    if (gameManager.state == GameState.NotStarted) gameManager.startGame();
    if (square.state == SquareStateType.Closed) playTrack(GameAudioTrack.Flag);

    boardState.setBoard(
        boardState.service.toggleSquare(boardState.boardSquares, square));
  }

  void openSquare(BuildContext context, Square square) {
    if (gameManager.ended) return;
    if (square.state == SquareStateType.Opened ||
        square.state == SquareStateType.Flagged ||
        square.state == SquareStateType.Marked) return;
    if (gameManager.state == GameState.NotStarted) {
      int index;
      List<Square> boardSquares;
      if (gameManager.openingMoveMode) {
        index = boardState.service.coordinateToIndex(square.cell);
        boardSquares =
            boardState.service.clearNeighbors(boardState.boardSquares, square);
      } else if (gameManager.isFirstSafeMove) {
        index = boardState.service.coordinateToIndex(square.cell);
        boardSquares =
            boardState.service.moveMine(boardState.boardSquares, square);
      }
      if (boardSquares != null && index != null) {
        boardState.setBoard(boardSquares);
        square = boardSquares[index];
      }
    }
    playTrack(GameAudioTrack.Click);
    if (square.type == SquareType.Mine) {
      revealMine(context, square);
    } else {
      revealSquare(context, square);
    }
  }

  void revealMine(BuildContext context, Square square) {
    playTrack(GameAudioTrack.Explode);
    if (!gameManager.ended) gameManager.endGame(false);
    if (boardState.service.checkSquaresRemaining(boardState.boardSquares) -
            boardState.service.options.mines <=
        (boardState.service.totalSquares * 0.05).ceil())
      playTrack(GameAudioTrack.Lose);
    boardState.setBoard(
        boardState.service.revealMines(boardState.boardSquares, square));
    showMessage(context, false);
  }

  void revealSquare(BuildContext context, Square square) {
    if (gameManager.state == GameState.NotStarted) gameManager.startGame();
    final oldBoardSate = boardState.boardSquares;
    final newBoardState =
        boardState.service.revealSquares(boardState.boardSquares, square);
    boardState.setBoard(newBoardState);
    if (boardState.service.checkWin(boardState.boardSquares)) {
      if (!gameManager.ended) gameManager.endGame(true);
      showMessage(context, true);
      playTrack(GameAudioTrack.Win);
    } else {
      final squaresRemainingOld =
          boardState.service.checkSquaresRemaining(oldBoardSate);
      final squaresRemainingNew =
          boardState.service.checkSquaresRemaining(newBoardState);
      if ((squaresRemainingOld - squaresRemainingNew) > 1) {
        playTrack(GameAudioTrack.Opening);
      }
    }
  }

  void playTrack(GameAudioTrack track) {
    if (!gameManager.audioMuted) {
      GameAudioService.playTrack(track);
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
          gameManager.options.dimensions.total,
          (index) {
            final square = boardState.boardSquares.elementAt(index);
            return SquareTile(
              square: square,
              showContents: gameManager.playTestMode,
              onMark: () => markSquare(square),
              onOpen: () => openSquare(context, square),
            );
          },
        ),
      ),
    );
  }
}
