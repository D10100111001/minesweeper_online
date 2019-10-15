import 'package:flutter/material.dart';
import 'package:minesweeper_online/app.dart';
import 'package:minesweeper_online/models/game_storage_settings.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final gameStorage = await GameStorage.getFromStorage();
  runApp(MyApp(gameStorage: null));
}

class MyApp extends StatelessWidget {
  final GameStorage gameStorage;
  MyApp({@required this.gameStorage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GameStorage>.value(value: gameStorage),
        ChangeNotifierProvider<GameManagerState>.value(
          value: GameManagerState(
              initialOptions: GameManagerState.PresetGameOptions[
                  gameStorage?.defaultGameMode ?? PresetGameOption.Beginner],
              isDarkMode: gameStorage?.isDarkMode),
        ),
      ],
      child: App(),
    );
  }
}
