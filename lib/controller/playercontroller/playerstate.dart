import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:myapp/services/audio_cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:audio_service/audio_service.dart';

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
  final AudioCacheService _audioCacheService = AudioCacheService();

  PlayerState() {
    _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        await _playNextRelatedSong();
      }
    });

    // Listen to AudioService state changes
    AudioService.playbackStateStream.listen((playbackState) {
      if (playbackState.playing != _audioPlayer.playing) {
        if (playbackState.playing) {
          _audioPlayer.play();
        } else {
          _audioPlayer.pause();
        }
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

    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }

    await AudioService.start(
      backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Your Channel Name',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      params: {
        'mediaItem': MediaItem(
          id: 'some_unique_id',
          album: '',
          title: title,
          artist: artist,
          duration: Duration.zero,
          artUri: Uri.parse(thumbnailUrl),
          extras: {'audioUrl': audioUrl},
        ),
      },
    );

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

    await _savePlayedSong(title, artist, thumbnailUrl, audioUrl);
    await _fetchRelatedVideos(title);
  }

  void pause() {
    _audioPlayer.pause().then((_) {
      notifyListeners();
      AudioService.pause();
    });
  }

  void stop() {
    _audioPlayer.stop().then((_) {
      _isMiniPlayerVisible = false;
      _wasPlaying = false;
      notifyListeners();
      AudioService.stop();
    });
  }

  Future<void> _fetchRelatedVideos(String title) async {
    _relatedVideos = await _youtubeService.fetchRelatedVideos(title);
    await _audioCacheService.prefetchAudioStreams(_relatedVideos);
  }

  Future<void> _playNextRelatedSong() async {
    while (_relatedVideos.isNotEmpty) {
      final nextVideo = _relatedVideos.removeAt(0);
      if (!_playedSongs.any((song) =>
          song['title']!.toLowerCase() == nextVideo.title.toLowerCase())) {
        final nextTitle = nextVideo.title;
        final nextArtist = nextVideo.author;
        final nextThumbnailUrl =
            nextVideo.thumbnails.maxResUrl;

        final cachedAudioUrl = await _audioCacheService.getCachedAudioUrl(nextVideo.id.value);
        if (cachedAudioUrl != null) {
          await play(nextTitle, nextArtist, nextThumbnailUrl, cachedAudioUrl);
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
    final now = DateTime.now().toIso8601String();
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
