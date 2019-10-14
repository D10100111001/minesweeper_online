import 'package:flutter/material.dart';
import 'package:minesweeper_online/app.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameManagerState>(
      builder: (_) => GameManagerState(
        initialOptions:
            GameManagerState.PresetGameOptions[PresetGameOption.Beginner],
      ),
      child: App(),
    );
  }
}
