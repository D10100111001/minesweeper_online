import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/minesweeper.dart';
import 'package:minesweeper_online/page.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class MinesweeperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameManager = Provider.of<GameManagerState>(context);

    return Page(
      child: Center(
        child: Minesweeper(
          gameManager: gameManager,
        ),
      ),
    );
  }
}
