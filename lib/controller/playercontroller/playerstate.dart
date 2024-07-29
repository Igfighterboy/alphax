import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerState with ChangeNotifier {
  String _title = '';
  String _artist = '';
  String _thumbnailUrl = '';
  String _audioUrl = '';
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMiniPlayerVisible = false;
  bool _wasPlaying = false;
  bool _isLoading = false;
  List<Video> _relatedVideos = [];
  List<Map<String, String>> _playedSongs = [];

  final YoutubeService _youtubeService = YoutubeService();

  PlayerState() {
    _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        await _playNextRelatedSong();
      }
    });
  }

  String get title => _title;
  String get artist => _artist;
  String get thumbnailUrl => _thumbnailUrl;
  AudioPlayer get audioPlayer => _audioPlayer;
  bool get isPlaying => _audioPlayer.playing;
  bool get isMiniPlayerVisible => _isMiniPlayerVisible || _wasPlaying;
  bool get isLoading => _isLoading;
  List<Map<String, String>> get playedSongs => _playedSongs;

  Future<void> play(
      String title, String artist, String thumbnailUrl, String audioUrl) async {
    _isLoading = true;
    notifyListeners();

    await _audioPlayer.setUrl(audioUrl);
    _audioPlayer.play();

    _title = title;
    _artist = artist;
    _thumbnailUrl = thumbnailUrl;
    _audioUrl = audioUrl;
    _wasPlaying = true;
    _isLoading = false;
    _isMiniPlayerVisible = true;
    notifyListeners();

    // Save played song and fetch related videos
    await _savePlayedSong(title, artist, thumbnailUrl, audioUrl);
    await _fetchRelatedVideos(title);
  }

  void pause() {
    _audioPlayer.pause().then((_) {
      notifyListeners();
    });
  }

  void stop() {
    _audioPlayer.stop().then((_) {
      _isMiniPlayerVisible = false;
      _wasPlaying = false;
      notifyListeners();
    });
  }

  Future<void> _fetchRelatedVideos(String title) async {
    _relatedVideos = await _youtubeService.fetchRelatedVideos(title);
  }

  Future<void> _playNextRelatedSong() async {
    while (_relatedVideos.isNotEmpty) {
      final nextVideo = _relatedVideos.removeAt(0);
      if (!_playedSongs.any((song) =>
          song['title']!.toLowerCase() == nextVideo.title.toLowerCase())) {
        final nextTitle = nextVideo.title;
        final nextArtist = nextVideo.author;
        final nextThumbnailUrl =
            nextVideo.thumbnails.maxResUrl; // Use max resolution URL

        final audioStreamInfo =
            await _youtubeService.getAudioStream(nextVideo.id.value);
        if (audioStreamInfo != null) {
          final nextAudioUrl = audioStreamInfo.url.toString();

          await play(nextTitle, nextArtist, nextThumbnailUrl, nextAudioUrl);
          return;
        }
      }
    }
    stop();
  }

  void updatePlayedSongs(List<Map<String, String>> playedSongs) {
    _playedSongs = playedSongs;
    notifyListeners();
  }

  Future<void> _savePlayedSong(
    String title, String artist, String thumbnailUrl, String audioUrl) async {
    final now = DateTime.now().toIso8601String(); // Add a timestamp for sorting
    final song = {
      'title': title,
      'artist': artist,
      'thumbnailUrl': thumbnailUrl,
      'audioUrl': audioUrl,
      'timestamp': now,
    };

    _playedSongs.removeWhere((existingSong) => existingSong['title'] == title);
    _playedSongs.insert(0, song);

    final prefs = await SharedPreferences.getInstance();
    final playedSongsJson = json.encode(_playedSongs);
    await prefs.setString('playedSongs', playedSongsJson);

    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _youtubeService.dispose();
    super.dispose();
  }
}
