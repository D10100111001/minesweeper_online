import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:minesweeper_online/app.dart';
import 'package:minesweeper_online/models/game_settings.dart';
import 'package:minesweeper_online/services/audio_service.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

import 'is_browser/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GameAudioService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  Future<Box<dynamic>> _openBoxes() async {
    if (!isBrowser) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    return await Hive.openBox('settings');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _openBoxes(),
      builder: (context, AsyncSnapshot<Box<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            print(snapshot.error);
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Something went wrong :/'),
                ),
              ),
            );
          } else {
            var settings = GameSettings.load(snapshot.data);
            return MultiProvider(
              providers: [
                Provider<GameSettings>(builder: (_) => settings),
                ChangeNotifierProvider<GameManagerState>(
                  builder: (_) => GameManagerState(initialSettings: settings),
                ),
              ],
              child: MinesweeperApp(),
            );
          }
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
