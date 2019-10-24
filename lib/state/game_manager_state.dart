import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minesweeper_online/helpers/parsers.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/game_settings.dart';
import 'package:minesweeper_online/models/game_state.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';

enum PresetGameOption { Beginner, Intermediate, Expert }

class GameManagerState with ChangeNotifier {
  GameManagerState({@required GameSettings initialSettings}) {
    _options = GameManagerState.PresetGameOptions[
        initialSettings?.defaultGameMode ?? PresetGameOption.Beginner];
    if (initialSettings?.isDarkMode != null) {
      _mode = initialSettings.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }
    if (initialSettings?.audioMuted != null) {
      _audioMuted = initialSettings.audioMuted;
    }
    if (initialSettings?.isOnline != null) {
      _offlineMode = !initialSettings.isOnline;
    }
    // if (initialSettings?.boardId != null) {
    //   _mode = initialSettings.isDarkMode ? ThemeMode.dark : ThemeMode.dark;
    // }
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
    Hive.box("settings").put('isDarkMode', true);
    notifyListeners();
  }

  setLightTheme() {
    _mode = ThemeMode.light;
    Hive.box("settings").put('isDarkMode', false);
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
    Hive.box("settings")
        .put('presetGameOption', ParserUtility.getEnumValue(presetGameOption));
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
    updateAudioMute(true);
  }

  unMuteAudio() {
    updateAudioMute(false);
  }

  toggleAudio() {
    updateAudioMute(!_audioMuted);
  }

  updateAudioMute(bool mute) {
    _audioMuted = mute;
    Hive.box("settings").put('isAudioMuted', false);
    notifyListeners();
  }

  setGameOptionParams(int rows, int columns, int mines) {
    setGameOptions(GameOptions(
        dimensions: MatrixDimensions(rows: rows, columns: columns),
        mines: mines));
  }
}
