import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/models/square_state_type.dart';
import 'package:minesweeper_online/models/square_type.dart';
import 'package:minesweeper_online/services/square_service.dart';
import 'package:minesweeper_online/square_tile.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';

class Board extends StatefulWidget {
  final GameManagerState gameManager;
  const Board({Key key, @required this.gameManager}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Square> boardSquares;

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  void _resetBoard() {
    boardSquares = SweeperService(options: widget.gameManager.options)
        .generateBoardSquares();
  }

  @override
  void didUpdateWidget(Board oldBoard) {
    if (widget.gameManager.state == GameState.NotStarted) {
      _resetBoard();
    }
    super.didUpdateWidget(oldBoard);
  }

  void markSquare(Square square) {
    if (widget.gameManager.state == GameState.Ended) return;
    if (square.state == SquareStateType.Opened) return;
    SweeperService service = SweeperService(
      options: widget.gameManager.options,
    );
    setState(() {
      boardSquares = service.toggleSquare(boardSquares, square);
    });
  }

  void openSquare(Square square) {
    if (widget.gameManager.state == GameState.Ended) return;
    if (square.state == SquareStateType.Opened ||
        square.state == SquareStateType.Flagged ||
        square.state == SquareStateType.Marked) return;
    if (square.type == SquareType.Mine) {
      revealMine(square);
    } else {
      revealSquare(square);
    }
  }

  void revealMine(Square square) {
    SweeperService service = SweeperService(
      options: widget.gameManager.options,
    );
    if (widget.gameManager.state != GameState.Ended)
      widget.gameManager.endGame();
    setState(() {
      boardSquares = service.revealMines(boardSquares, square);
    });
    showMessage(false);
  }

  void revealSquare(Square square) {
    SweeperService service = SweeperService(
      options: widget.gameManager.options,
    );
    if (widget.gameManager.state == GameState.NotStarted)
      widget.gameManager.startGame();
    setState(() {
      boardSquares = service.revealSquares(boardSquares, square);
    });
    if (service.checkWin(boardSquares)) showMessage(true);
  }

  void showMessage([bool win = false]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(win ? "Congratulations!" : "Game Over!"),
          content: Text(win ? "You Win!" : "You stepped on a mine!"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  _resetBoard();
                });
                widget.gameManager.restartGame();
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
    return Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          Divider.createBorderSide(context),
        ),
      ),
      margin: const EdgeInsets.all(10.0),
      child: GridView.count(
        shrinkWrap: true,
        primary: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0.0),
        crossAxisCount: widget.gameManager.options.dimensions.rows,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
        children: List.generate(
          widget.gameManager.options.dimensions.rows *
              widget.gameManager.options.dimensions.columns,
          (index) {
            final square = boardSquares.elementAt(index);
            return SquareTile(
              square: square,
              onMark: () => markSquare(square),
              onOpen: () => openSquare(square),
            );
          },
        ),
      ),
    );
  }
}
