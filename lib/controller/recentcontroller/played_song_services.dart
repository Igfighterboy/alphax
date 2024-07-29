import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PlayedSongsService {
  Future<List<Map<String, String>>> loadPlayedSongs() async {
    final prefs = await SharedPreferences.getInstance();
    final playedSongsJson = prefs.getString('playedSongs');

    if (playedSongsJson != null) {
      final List<dynamic> decodedList = json.decode(playedSongsJson);
      final List<Map<String, String>> playedSongs = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .map((Map<String, dynamic> item) {
            return item.map((key, value) => MapEntry(key, value.toString()));
          })
          .toList();

      return playedSongs;
    }

    return [];
  }

  Future<void> savePlaybackState(String songId, Duration position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentSongId', songId);
    await prefs.setInt('currentPosition', position.inMilliseconds);
  }

  Future<Map<String, dynamic>?> loadPlaybackState() async {
    final prefs = await SharedPreferences.getInstance();
    final songId = prefs.getString('currentSongId');
    final position = prefs.getInt('currentPosition');

    if (songId != null && position != null) {
      return {
        'songId': songId,
        'position': Duration(milliseconds: position),
      };
    }
    return null;
  }
}