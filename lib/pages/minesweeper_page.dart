import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/minesweeper/minesweeper.dart';
import 'package:minesweeper_online/page.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class MinesweeperPage extends StatelessWidget {
  void showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Instructions"),
          content: Text(
              "Reveal: Left-click\nFlag: Hold Left-click\nMark: Hold Left-click after flagging\nYellow face/F2: Restart game"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
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
                  child: Text('Instructions'),
                  onPressed: () => showInstructions(context),
                ),
                OutlineButton(
                  child: Text('Beginner'),
                  onPressed: () => gameManager
                      .setGameOptionPreset(PresetGameOption.Beginner),
                ),
                OutlineButton(
                  child: Text('Intermediate'),
                  onPressed: () => gameManager
                      .setGameOptionPreset(PresetGameOption.Intermediate),
                ),
                OutlineButton(
                  child: Text('Expert'),
                  onPressed: () =>
                      gameManager.setGameOptionPreset(PresetGameOption.Expert),
                ),
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
