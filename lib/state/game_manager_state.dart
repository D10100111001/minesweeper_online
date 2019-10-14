import 'package:flutter/foundation.dart';
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

  endGame() {
    if (_state == GameState.Ended) return;
    _state = GameState.Ended;
    notifyListeners();
  }

  setGameOptions(GameOptions newOptions) {
    _state = GameState.NotStarted;
    _options = newOptions;
    notifyListeners();
  }
}
