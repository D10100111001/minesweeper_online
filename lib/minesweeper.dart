import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/board.dart';
import 'package:minesweeper_online/hud.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/services/square_service.dart';
import 'package:minesweeper_online/state/board_state.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class Minesweeper extends StatelessWidget {
  final GameManagerState gameManager;
  const Minesweeper({Key key, @required this.gameManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          Divider.createBorderSide(context),
        ),
      ),
      child: ChangeNotifierProxyProvider<GameManagerState, BoardState>(
        initialBuilder: (_) =>
            BoardState(service: SweeperService(options: gameManager.options)),
        builder: (_, gameManager, boardState) {
          if (gameManager.state == GameState.NotStarted) {
            boardState.resetBoard();
          }
          return boardState;
        },
        child: SizedBox(
          width: gameManager.options.dimensions.columns * 32.0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Hud(
                gameManager: gameManager,
              ),
              Builder(
                builder: (context) {
                  final boardState = Provider.of<BoardState>(context);
                  return Board(
                    boardState: boardState,
                    gameManager: gameManager,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
