import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';

enum PresetGameOption { Beginner, Intermediate, Expert }

class GameManagerState with ChangeNotifier {
  GameManagerState({@required GameOptions initialOptions}) {
    _options = initialOptions;
  }

  GameOptions _options;
  GameOptions get options => _options;

  GameState _state = GameState.NotStarted;
  GameState get state => _state;

  ThemeMode _mode = kDebugMode ? ThemeMode.dark : ThemeMode.system;
  ThemeMode get mode => _mode;

  bool get won => _state == GameState.Won;
  bool get ended => _state == GameState.Won || _state == GameState.Loss;

  setDarkTheme() {
    _mode = ThemeMode.dark;
    notifyListeners();
  }

  setLightTheme() {
    _mode = ThemeMode.light;
    notifyListeners();
  }

  restartGame() {
    if (_state == GameState.NotStarted) return;
    _state = GameState.NotStarted;
    notifyListeners();
  }

  startGame() {
    if (_state == GameState.Started) return;
    _state = GameState.Started;
    notifyListeners();
  }

  endGame([bool win = false]) {
    if (_state == GameState.Won || _state == GameState.Loss) return;
    _state = win ? GameState.Won : GameState.Loss;
    notifyListeners();
  }

  setGameOptions(GameOptions newOptions) {
    _state = GameState.NotStarted;
    _options = newOptions;
    notifyListeners();
  }

  static const PresetGameOptions = {
    PresetGameOption.Beginner: const GameOptions(
        dimensions: const MatrixDimensions(rows: 9, columns: 9), mines: 10),
    PresetGameOption.Intermediate: const GameOptions(
        dimensions: const MatrixDimensions(rows: 16, columns: 16), mines: 40),
    PresetGameOption.Expert: const GameOptions(
        dimensions: const MatrixDimensions(rows: 16, columns: 30), mines: 99),
  };

  setGameOptionPreset(PresetGameOption presetGameOption) {
    setGameOptions(PresetGameOptions[presetGameOption]);
  }

  setGameOptionParams(int rows, int columns, int mines) {
    setGameOptions(GameOptions(
        dimensions: MatrixDimensions(rows: rows, columns: columns),
        mines: mines));
  }
}
