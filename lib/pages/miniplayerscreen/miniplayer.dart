import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:myapp/services/youtube_services.dart';

class MiniPlayer extends StatefulWidget {
  final Video? video;

  const MiniPlayer({Key? key, this.video}) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final YoutubeService _youtubeService = YoutubeService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (_isPlaying) {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      try {
        final audioStreamInfo = await _youtubeService.getAudioStream(widget.video!.id.value);
        final audioUrl = audioStreamInfo.url.toString();
        await _audioPlayer.setUrl(audioUrl);
        _audioPlayer.play();
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.video == null) {
      return Container(); // Return an empty container when no video is provided.
    }

    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.video!.thumbnails.standardResUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.video!.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.video!.author,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: _playPauseAudio,
          ),
        ],
      ),
    );
  }
}