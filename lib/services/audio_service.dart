import 'package:audioplayers/audioplayers.dart';

enum GameAudioTrack { Click, Opening, Flag, Win, Explode, Lose }

class GameAudioService {
  static const pathPrefix = 'audio/';
  static final AudioPlayer player = AudioPlayer();

  static String toFileName(GameAudioTrack value) =>
      value.toString().split('.')[1].toLowerCase() + '.mp3';

  static Future<void> init() async {}

  static Future<void> playTrack(GameAudioTrack track) async {
    final path = toFileName(track);
    await player.play(
      AssetSource('$pathPrefix$path'),
      mode: PlayerMode.lowLatency,
    );
  }
}
