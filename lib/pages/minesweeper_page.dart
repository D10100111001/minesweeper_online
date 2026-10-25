import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_online/minesweeper/minesweeper.dart';
import 'package:minesweeper_online/page.dart' as app_page;
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class MinesweeperPage extends StatelessWidget {
  void showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Instructions"),
          content: SingleChildScrollView(
            child: Text(
              "Desktop:\nReveal: Left-click\nFlag: Right-click\nMark: Right-click after flagging\n\nMobile:\nReveal: Tap\nFlag: Long-tap\nMark: Long-tap after flagging\n\nYellow smiley: Restart game",
            ),
          ),
          actions: <Widget>[
            TextButton(
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

  Widget createOptionsBooleanListItem(BuildContext context, IconData icon,
      String title, String description, bool val, VoidCallback onChange) {
    return SizedBox(
      width: 600.0,
      child: MergeSemantics(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          title: Text(
            title,
            textAlign: TextAlign.left,
          ),
          subtitle: Text(
            description,
            textAlign: TextAlign.left,
          ),
          leading: Icon(icon),
          trailing: CupertinoSwitch(
            activeTrackColor: Colors.green,
            value: val,
            onChanged: (_) => onChange(),
          ),
          onTap: onChange,
        ),
      ),
    );
  }

  void showOptionsDialog(BuildContext context, GameManagerState gameManager) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Options"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createOptionsBooleanListItem(
                    context,
                    Icons.settings,
                    'Play-test',
                    'Show the contents of all unopened cells. Scores do not count towards high scores, and the Opening Move and Free Safe Move options do not apply.',
                    gameManager.playTestMode,
                    () =>
                        gameManager.setPlayTestMode(!gameManager.playTestMode)),
                createOptionsBooleanListItem(
                    context,
                    Icons.cloud_off,
                    'Offline Mode',
                    'Scores do not count towards high scores.',
                    gameManager.offlineMode,
                    () => gameManager.setOfflineMode(!gameManager.offlineMode)),
                createOptionsBooleanListItem(
                    context,
                    Icons.outlined_flag,
                    'Free Safe Move',
                    'The first move/square will never be a mine. It is a free and safe move.',
                    gameManager.isFirstSafeMove,
                    () => gameManager
                        .setIsFirstSafeMove(!gameManager.isFirstSafeMove)),
                createOptionsBooleanListItem(
                    context,
                    Icons.open_with,
                    'Opening Move',
                    'Not only will the first square never be a mine, but neither will any of the neighbors.',
                    gameManager.openingMoveMode,
                    () => gameManager
                        .setOpeningMove(!gameManager.openingMoveMode)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
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

    return app_page.Page(
      child: Center(
        child: Column(children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              OutlinedButton(
                child: Text('Instructions'),
                onPressed: () => showInstructions(context),
              ),
              OutlinedButton(
                child: Text('Beginner'),
                onPressed: () =>
                    gameManager.setGameOptionPreset(PresetGameOption.Beginner),
              ),
              OutlinedButton(
                child: Text('Intermediate'),
                onPressed: () => gameManager
                    .setGameOptionPreset(PresetGameOption.Intermediate),
              ),
              OutlinedButton(
                child: Text('Expert'),
                onPressed: () =>
                    gameManager.setGameOptionPreset(PresetGameOption.Expert),
              ),
              OutlinedButton(
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
          SizedBox(
            height: 15.0,
          ),
          Minesweeper(
            gameManager: gameManager,
          ),
        ]),
      ),
    );
  }
}
