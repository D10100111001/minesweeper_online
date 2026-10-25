import 'package:flutter/material.dart';
import 'package:minesweeper_online/helpers/box_decoration.dart';
import 'package:minesweeper_online/minesweeper/board.dart';
import 'package:minesweeper_online/minesweeper/hud.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/services/square_service.dart';
import 'package:minesweeper_online/state/board_state.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class Minesweeper extends StatelessWidget {
  final GameManagerState gameManager;
  const Minesweeper({super.key, required this.gameManager});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecorationHelper.buildMinesweeperDecoration(
          themeData.toggleButtonsTheme),
      child: ChangeNotifierProxyProvider<GameManagerState, BoardState>(
        create: (_) =>
            BoardState(service: SweeperService(options: gameManager.options)),
        update: (_, manager, boardState) {
          final currentBoard = boardState ??
              BoardState(service: SweeperService(options: manager.options));
          if (manager.state == GameState.NotStarted) {
            if (currentBoard.service.options != manager.options)
              return BoardState(
                  service: SweeperService(options: manager.options));
            else if (!currentBoard.isPristine) currentBoard.resetBoard();
          }
          return currentBoard;
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
