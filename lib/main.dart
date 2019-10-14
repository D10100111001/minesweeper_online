import 'package:flutter/material.dart';
import 'package:minesweeper_online/app.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameManagerState>(
      builder: (_) => GameManagerState(
        initialOptions: GameOptions(
          dimensions: const MatrixDimensions(
            rows: 9,
            columns: 9,
          ),
          mines: 10,
        ),
      ),
      child: App(),
    );
  }
}
