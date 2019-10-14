import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/game_state.dart';

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
}
