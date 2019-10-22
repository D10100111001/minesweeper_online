import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';

@HiveType()
class GameSettings extends HiveObject {

  @HiveField(0)
  final bool isDarkMode;
  @HiveField(1)
  final PresetGameOption defaultGameMode;
  @HiveField(2)
  final bool isOnline;
  @HiveField(3)
  final String boardId;
  GameSettings(
      {@required this.isDarkMode,
      @required this.defaultGameMode,
      @required this.isOnline,
      @required this.boardId});

  load() async  {
    
  }
}
