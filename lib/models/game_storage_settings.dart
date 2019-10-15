import 'package:flutter/foundation.dart';
//import 'package:minesweeper_online/helpers/parsers.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';

@immutable
class GameStorage {
  final bool isDarkMode;
  final PresetGameOption defaultGameMode;
  final bool isOnline;
  final String boardId;
  const GameStorage(
      {@required this.isDarkMode,
      @required this.defaultGameMode,
      @required this.isOnline,
      @required this.boardId});

  // static Future<GameStorage> getFromStorage() async {
  //   final service = StorageService();
  //   bool isDarkMode =
  //       ParserUtility.toBoolean(await service.getVal("isDarkMode"));
  //   PresetGameOption defaultGameMode = ParserUtility.toEnum(
  //       PresetGameOption.values, await service.getVal("defaultGameMode"));
  //   bool isOnline = ParserUtility.toBoolean(await service.getVal("isOnline"));
  //   String boardId = await service.getVal("boardId");

  //   return GameStorage(
  //     isDarkMode: isDarkMode,
  //     defaultGameMode: defaultGameMode,
  //     isOnline: isOnline,
  //     boardId: boardId,
  //   );
  // }
}
