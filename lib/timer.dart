import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:minesweeper_online/state/timer_state.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  final Widget child;
  final bool countDown;
  Timer({@required this.child, this.countDown = true});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<GameManagerState, TimerState>(
      initialBuilder: (_) => TimerState(countDown: countDown),
      builder: (_, gameManager, timer) {
        if (gameManager.state == GameState.NotStarted) {
          timer.stop();
          timer.reset();
        } else if (gameManager.state == GameState.Started) {
          timer.start();
        } else if (gameManager.ended) {
          timer.stop();
        }
        return timer;
      },
      child: child,
    );
  }
}
