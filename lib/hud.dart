import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/counter.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/state/board_state.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:minesweeper_online/state/timer_state.dart';
import 'package:minesweeper_online/timer.dart';
import 'package:provider/provider.dart';

class Hud extends StatelessWidget {
  final GameManagerState gameManager;
  Hud({this.gameManager});

  static const GameStateIconMap = {
    GameState.NotStarted: Icons.sentiment_very_satisfied,
    GameState.Started: Icons.sentiment_satisfied,
    GameState.Ended: Icons.sentiment_very_dissatisfied
  };

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<BoardState>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            Divider.createBorderSide(context),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Counter(
              label: 'Mines Remaining',
              count: gameManager.options.mines - board.service.countFlags(board.boardSquares),
            ),
            Tooltip(
              message: 'Restart Game',
              child: IconButton(
                icon: Icon(GameStateIconMap[gameManager.state]),
                color: Colors.yellow,
                onPressed: () => gameManager.restartGame(),
              ),
            ),
            Timer(
              countDown: false,
              child: Builder(
                builder: (context) {
                  final timerState = Provider.of<TimerState>(context);
                  return Counter(
                    label: 'Seconds Elapsed',
                    count: timerState.time,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
