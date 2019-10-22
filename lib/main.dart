import 'package:flutter/material.dart';
import 'package:minesweeper_online/app.dart';
import 'package:minesweeper_online/models/game_settings.dart';
import 'package:minesweeper_online/services/audio_service.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GameAudioService.init();
  runApp(MyApp(gameSettings: null));
}

class MyApp extends StatelessWidget {
  final GameSettings gameSettings;
  MyApp({@required this.gameSettings});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GameSettings>(builder: (_) => gameSettings),
        ChangeNotifierProvider<GameManagerState>(
          builder: (_) => GameManagerState(
              initialOptions: GameManagerState.PresetGameOptions[
                  gameSettings?.defaultGameMode ?? PresetGameOption.Beginner],
              isDarkMode: gameSettings?.isDarkMode),
        ),
      ],
      child: App(),
    );
  }
}
