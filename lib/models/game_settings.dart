import 'package:hive/hive.dart';
import 'package:minesweeper_online/helpers/parsers.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';

class GameSettings {
  final bool isDarkMode;
  final PresetGameOption? defaultGameMode;
  final bool audioMuted;
  final bool isOnline;
  final String? boardId;
  GameSettings(
      {required this.isDarkMode,
      required this.defaultGameMode,
      required this.audioMuted,
      required this.isOnline,
      required this.boardId});

  factory GameSettings.load(Box<dynamic> box) {
    final isDarkMode = box.get('isDarkMode') as bool? ?? false;
    final presetGameOption = ParserUtility.toEnum(
      PresetGameOption.values,
      box.get('presetGameOption') as String? ?? 'Beginner',
    );
    final audioMuted = box.get('isAudioMuted') as bool? ?? true;
    return GameSettings(
        isDarkMode: isDarkMode,
        defaultGameMode: presetGameOption,
        audioMuted: audioMuted,
        isOnline: true,
        boardId: null);
  }
}
