import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';

enum PresetGameOption { Beginner, Intermediate, Expert }

class GameManagerState with ChangeNotifier {
  GameManagerState(
      {@required GameOptions initialOptions, @required bool isDarkMode}) {
    _options = initialOptions;
    if (isDarkMode != null)
      _mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool _audioMuted = true;
  bool get audioMuted => _audioMuted;

  bool _playTestMode = false;
  bool get playTestMode => _playTestMode;
  bool _offlineMode = false;
  bool get offlineMode => _offlineMode;
  bool _isFirstSafeMove = true;
  bool get isFirstSafeMove => _isFirstSafeMove;
  bool _openingMoveMode = true;
  bool get openingMoveMode => _openingMoveMode;

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
    //StorageService().setVal("isDarkMode", true.toString());
    notifyListeners();
  }

  setLightTheme() {
    _mode = ThemeMode.light;
    //StorageService().setVal("isDarkMode", false.toString());
    notifyListeners();
  }

  restartGame([force = false]) {
    if (_state == GameState.NotStarted && !force) return;
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
    //StorageService()
    //.setVal("defaultGameMode", presetGameOption.toString().split('.')[1]);
    setGameOptions(PresetGameOptions[presetGameOption]);
  }

  setPlayTestMode([bool enabled = true]) {
    _playTestMode = enabled;
    if (_playTestMode) {
      _offlineMode = true;
      if (!kDebugMode) {
        _openingMoveMode = false;
        _isFirstSafeMove = false;
      }
    }
    restartGame(true);
  }

  setOfflineMode([bool enabled = true]) {
    _offlineMode = enabled;
    if (!_offlineMode) _playTestMode = false;
    restartGame(true);
  }

  setIsFirstSafeMove([bool enabled = true]) {
    _isFirstSafeMove = enabled;
    if (_isFirstSafeMove)
      _playTestMode = false;
    else
      _openingMoveMode = false;
    restartGame(true);
  }

  setOpeningMove([bool enabled = true]) {
    _openingMoveMode = enabled;
    if (_openingMoveMode) {
      _playTestMode = false;
      _isFirstSafeMove = true;
    }
    restartGame(true);
  }

  muteAudio() {
    _audioMuted = true;
    notifyListeners();
  }

  unMuteAudio() {
    _audioMuted = false;
    notifyListeners();
  }

  toggleAudio() {
    _audioMuted = !_audioMuted;
    notifyListeners();
  }

  setGameOptionParams(int rows, int columns, int mines) {
    setGameOptions(GameOptions(
        dimensions: MatrixDimensions(rows: rows, columns: columns),
        mines: mines));
  }
}
