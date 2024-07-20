import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class PlayerState with ChangeNotifier {
  String _title = '';
  String _artist = '';
  String _thumbnailUrl = '';
  Color _dominantColor = Colors.grey[900]!;
  String _audioUrl = '';
  final AudioPlayer _audioPlayer = AudioPlayer();

  String get title => _title;
  String get artist => _artist;
  String get thumbnailUrl => _thumbnailUrl;
  Color get dominantColor => _dominantColor;
  AudioPlayer get audioPlayer => _audioPlayer;

  bool get isPlaying => _audioPlayer.playing;

  void play(String title, String artist, String thumbnailUrl, Color dominantColor, String audioUrl) {
    _title = title;
    _artist = artist;
    _thumbnailUrl = thumbnailUrl;
    _dominantColor = dominantColor;
    _audioUrl = audioUrl;
    _audioPlayer.setUrl(_audioUrl);
    _audioPlayer.play();
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
