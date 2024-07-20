import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:myapp/controller/playercontroller/marquee.dart'; // Import the Marquee widget

class MiniPlayer extends StatefulWidget {
  final VoidCallback onExpand;

  MiniPlayer({required this.onExpand});

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {}); // Trigger a rebuild to update the progress bar
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerState>(
      builder: (context, playerState, child) {
        return Container(
          height: 135, // Adjusted height to fit the progress bar and controls
          color: playerState.dominantColor,
          padding: const EdgeInsets.all(8.0), // Add some padding
          child: Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    playerState.thumbnailUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Marquee(
                  text: playerState.title,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  playerState.artist,
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        playerState.audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (playerState.audioPlayer.playing) {
                          playerState.audioPlayer.pause();
                        } else {
                          playerState.audioPlayer.play();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.expand_less, color: Colors.white),
                      onPressed: widget.onExpand,
                    ),
                  ],
                ),
              ),
              // Progress bar
              playerState.audioPlayer.duration != null
                  ? Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4.0, // Height of the track
                            thumbColor: Colors.transparent, // Hide the thumb
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.white.withOpacity(0.5),
                            overlayColor: Colors.transparent, // Hide the overlay
                            trackShape: RectangularSliderTrackShape(), // Use a custom track shape
                            // Add a custom track shape to remove rounded ends
                            disabledActiveTrackColor: Colors.transparent,
                            disabledInactiveTrackColor: Colors.transparent,
                          ),
                          child: Slider(
                            value: playerState.audioPlayer.position.inSeconds.toDouble(),
                            min: 0.0,
                            max: playerState.audioPlayer.duration!.inSeconds.toDouble(),
                            onChanged: (value) {
                              playerState.audioPlayer.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        // Display current time and total duration
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}



