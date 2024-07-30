import 'dart:collection';
import 'dart:convert';
import 'package:myapp/services/youtube_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioCacheService {
  final Map<String, String> _cache = HashMap<String, String>();
  Future<void> loadAllCachedAudioUrls() async {
    final prefs = await SharedPreferences.getInstance();
    final playedSongsJson = prefs.getString('playedSongs');
    if (playedSongsJson != null) {
      final List<dynamic> playedSongsList = json.decode(playedSongsJson);
      for (var song in playedSongsList) {
        _cache[song['audioUrl']] = song['audioUrl'];
      }
    }
  }

  Future<void> cacheAudioStream(String videoId, String audioUrl) async {
    _cache[videoId] = audioUrl;
  }

  Future<String?> getCachedAudioUrl(String videoId) async {
    return _cache[videoId];
  }

  Future<void> prefetchAudioStreams(List<Video> videos) async {
    for (var video in videos) {
      String? cachedUrl = await getCachedAudioUrl(video.id.value);
      if (cachedUrl == null) {
        final youtubeService = YoutubeService();
        final audioStreamInfo = await youtubeService.getAudioStream(video.id.value);
        await cacheAudioStream(video.id.value, audioStreamInfo.url.toString());
      }
    }
  }
}
