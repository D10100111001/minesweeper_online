import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:minesweeper_online/state/timer_state.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  final Widget child;
  final bool countDown;
  Timer({super.key, required this.child, this.countDown = true});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<GameManagerState, TimerState>(
      create: (_) => TimerState(countDown: countDown),
      update: (_, gameManager, timer) {
        final currentTimer = timer ?? TimerState(countDown: countDown);
        if (gameManager.state == GameState.NotStarted) {
          currentTimer.stop();
          currentTimer.reset();
        } else if (gameManager.state == GameState.Started) {
          currentTimer.start();
        } else if (gameManager.ended) {
          currentTimer.stop();
        }
        return currentTimer;
      },
      child: child,
    );
  }
}
