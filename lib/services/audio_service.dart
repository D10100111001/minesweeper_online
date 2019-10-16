import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

enum GameAudioTrack { Click, Opening, Flag, Win, Explode, Lose }

class GameAudioService {
  static AudioCache player = AudioCache(respectSilence: true);

  static final files = GameAudioTrack.values
      .map(toFileName).toList();

  static String toFileName(value) => value.toString().split('.')[1].toLowerCase() + '.mp3';

  static Future init() async {
    if (kIsWeb) return;
    await player.loadAll(files);
  }

  static void playTrack(GameAudioTrack track) {
    if (kIsWeb) return;
    player.play(toFileName(track), mode: PlayerMode.LOW_LATENCY);
  }
}
