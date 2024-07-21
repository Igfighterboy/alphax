import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class PlayerState with ChangeNotifier {
  String _title = '';
  String _artist = '';
  String _thumbnailUrl = '';
  Color _dominantColor = const Color.fromRGBO(33, 33, 33, 1);
  String _audioUrl = '';
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isMiniPlayerVisible = false;
  bool _wasPlaying = false;

  PlayerState() {
    _initializeNotifications();
  }

  String get title => _title;
  String get artist => _artist;
  String get thumbnailUrl => _thumbnailUrl;
  Color get dominantColor => _dominantColor;
  AudioPlayer get audioPlayer => _audioPlayer;
  bool get isPlaying => _audioPlayer.playing;
  bool get isMiniPlayerVisible => _isMiniPlayerVisible || _wasPlaying;

  void play(String title, String artist, String thumbnailUrl, Color dominantColor, String audioUrl) {
    _title = title;
    _artist = artist;
    _thumbnailUrl = thumbnailUrl;
    _dominantColor = dominantColor;
    _audioUrl = audioUrl;

    _audioPlayer.setUrl(_audioUrl).then((_) {
      _audioPlayer.play();
      _isMiniPlayerVisible = true;
      _wasPlaying = true;
      _updateNotification();
      notifyListeners();
    });
  }

  void pause() {
    _audioPlayer.pause().then((_) {
      _updateNotification();
      notifyListeners();
    });
  }

  void stop() {
    _audioPlayer.stop().then((_) {
      _isMiniPlayerVisible = false;
      _wasPlaying = false;
      _updateNotification();
      notifyListeners();
    });
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _updateNotification() {
    if (_audioPlayer.playing) {
      _flutterLocalNotificationsPlugin.show(
        0,
        _title,
        _artist,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id', // Channel ID
            'your_channel_name', // Channel Name
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
      );
    } else {
      _flutterLocalNotificationsPlugin.cancel(0); // Cancel the notification if not playing
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}