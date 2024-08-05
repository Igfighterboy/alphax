import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    final mediaItem = params?['mediaItem'] as MediaItem?;
    if (mediaItem != null) {
      await _audioPlayer.setUrl(mediaItem.extras?['audioUrl'] ?? '');
      _audioPlayer.play();
      _isPlaying = true;
      AudioServiceBackground.setMediaItem(mediaItem);
      AudioServiceBackground.setState(
        controls: [MediaControl.pause],
        playing: true,
        processingState: AudioProcessingState.ready,
      );

      _audioPlayer.playbackEventStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          AudioServiceBackground.setState(
            controls: [MediaControl.play],
            playing: false,
            processingState: AudioProcessingState.completed,
          );
        } else {
          AudioServiceBackground.setState(
            controls: [MediaControl.pause],
            playing: _audioPlayer.playing,
            processingState: AudioProcessingState.ready,
          );
        }
      });
    }
  }

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    await _audioPlayer.play();
    _isPlaying = true;
    AudioServiceBackground.setState(
      controls: [MediaControl.pause],
      playing: true,
      processingState: AudioProcessingState.ready,
    );
  }

  @override
  Future<void> onPause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    AudioServiceBackground.setState(
      controls: [MediaControl.play],
      playing: false,
      processingState: AudioProcessingState.ready,
    );
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }
}
