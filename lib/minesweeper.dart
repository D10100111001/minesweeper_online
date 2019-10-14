import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/board.dart';
import 'package:minesweeper_online/hud.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';

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
            Board(
              gameManager: gameManager,
            ),
          ],
        ),
      ),
    );
  }
}
