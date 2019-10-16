import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              "Reveal: Left-click\nFlag: Hold Left-click\nMark: Hold Left-click after flagging\nYellow smiley: Restart game"),
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

  void showOptionsDialog(BuildContext context, GameManagerState gameManager) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 400.0,
                child: MergeSemantics(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    title: Text(
                      'Play-test',
                      textAlign: TextAlign.left,
                    ),
                    leading: Icon(Icons.settings),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.green,
                      value: gameManager.playTestMode,
                      onChanged: (value) => gameManager.setPlayTestMode(value),
                    ),
                    onTap: () =>
                        gameManager.setPlayTestMode(!gameManager.playTestMode),
                  ),
                ),
              ),
              SizedBox(
                width: 400.0,
                child: MergeSemantics(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    title: Text(
                      'Offline Mode',
                      textAlign: TextAlign.left,
                    ),
                    leading: Icon(Icons.cloud_off),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.green,
                      value: gameManager.offlineMode,
                      onChanged: (value) => gameManager.setOfflineMode(value),
                    ),
                    onTap: () =>
                        gameManager.setOfflineMode(!gameManager.offlineMode),
                  ),
                ),
              ),
            ],
          ),
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

    return Page(
      child: Center(
        child: Column(children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              OutlineButton(
                child: Text('Instructions'),
                onPressed: () => showInstructions(context),
              ),
              OutlineButton(
                child: Text('Beginner'),
                onPressed: () =>
                    gameManager.setGameOptionPreset(PresetGameOption.Beginner),
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
              OutlineButton(
                child: Text('Options'),
                onPressed: () => showOptionsDialog(context, gameManager),
              ),
              IconButton(
                icon: Icon(
                  gameManager.audioMuted ? Icons.volume_off : Icons.volume_up,
                ),
                onPressed: () => gameManager.toggleAudio(),
              )
            ],
          ),
          SizedBox(height: 15.0,),
          Minesweeper(
            gameManager: gameManager,
          ),
        ]),
      ),
    );
  }
}
