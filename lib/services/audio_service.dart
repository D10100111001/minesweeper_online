import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:minesweeper_online/is_browser/main.dart';

enum GameAudioTrack { Click, Opening, Flag, Win, Explode, Lose }

class GameAudioService {
  static const PATH_PREFIX = 'audio/';
  static AudioCache player =
      AudioCache(respectSilence: true, prefix: PATH_PREFIX);

  static final files = GameAudioTrack.values.map(toFileName).toList();

  static String toFileName(value) =>
      value.toString().split('.')[1].toLowerCase() + '.mp3';

  static Future init() async {
    if (!isBrowser) await player.loadAll(files);
  }

  static Future playTrack(GameAudioTrack track) async {
    final path = toFileName(track);
    if (isBrowser)
      await AudioPlayer(mode: PlayerMode.LOW_LATENCY).play("$PATH_PREFIX$path");
    else
      await player.play(path, mode: PlayerMode.LOW_LATENCY);
  }
}
