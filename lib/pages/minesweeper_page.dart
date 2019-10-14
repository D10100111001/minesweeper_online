import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/minesweeper.dart';
import 'package:minesweeper_online/page.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class MinesweeperPage extends StatelessWidget {
  void showInstructions(BuildContext context) {
    final textStyle = TextStyle(fontFamily: "Raleway");
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Instructions", style: textStyle),
          content: Text(
              "Reveal: Left-click\nFlag: Hold Left-click\nMark: Hold Left-click after flagging\nYellow face/F2: Restart game",
              style: textStyle),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close", style: textStyle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameManager = Provider.of<GameManagerState>(context);

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.runtimeType.toString() == 'RawKeyUpEvent') {
          if (event.physicalKey == PhysicalKeyboardKey.f2) {
            gameManager.restartGame();
          }
        }
      },
      child: Page(
        child: Center(
          child: Column(children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  child: Text('Instructions',
                      style: TextStyle(fontFamily: 'Raleway')),
                  onPressed: () => showInstructions(context),
                )
              ],
            ),
            Minesweeper(
              gameManager: gameManager,
            ),
          ]),
        ),
      ),
    );
  }
}
