import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';
import 'package:minesweeper_online/pages/minesweeper_page.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: kDebugMode ? ThemeMode.dark : ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        textTheme:
            TextTheme(body2: TextStyle(color: Colors.red.withAlpha(200))),
        dividerColor: Colors.grey.withAlpha(200),
        toggleButtonsTheme: ToggleButtonsThemeData(
          borderColor: const Color(0x0F808080),
          color: const Color(0x0FFFFFFF),
          selectedBorderColor: const Color(0x0F808080),
          fillColor: const Color(0x0FC0C0C0),
        ),
        fontFamily: 'Minesweeper',
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        textTheme: TextTheme(body2: TextStyle(color: Colors.red)),
        dividerColor: Colors.grey,
        toggleButtonsTheme: ToggleButtonsThemeData(
          borderColor: const Color(0xFF808080),
          color: Colors.white,
          selectedBorderColor: const Color(0xFF808080),
          fillColor: const Color(0xFFC0C0C0),
        ),
        fontFamily: 'Minesweeper',
      ),
      home: ChangeNotifierProvider<GameManagerState>(
        builder: (_) => GameManagerState(
            initialOptions: GameOptions(
          dimensions: const MatrixDimensions(
            rows: 9,
            columns: 9,
          ),
          mines: 10,
        )),
        child: MinesweeperPage(),
      ),
    );
  }
}
