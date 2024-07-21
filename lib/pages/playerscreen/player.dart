import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
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
        setState(() {});
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
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: playerState.dominantColor,
            ),
            padding: const EdgeInsets.only(left: 10),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Thumbnail and song info
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          playerState.thumbnailUrl,
                          width: 60,
                          height: 60,
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
                          Marquee(
                            text: playerState.title,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'LexendDeca'),
                          ),
                          Text(
                            playerState.artist,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'LexendDeca',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    // Playback controls
                    IconButton(
                      icon: Icon(
                        playerState.audioPlayer.playing
                            ? Broken.pause
                            : Broken.play,
                        color: Colors.black,
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
                      icon: Icon(
                        Broken.heart,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Add functionality for the heart icon if needed
                      },
                    ),
                  ],
                ),

                // Include deprecated code for progress bar if needed
                // Add the progress bar and other controls here if required
                // Example:
                playerState.audioPlayer.duration != null
                    ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                          children: [
                            Slider(
                              value: playerState.audioPlayer.position.inSeconds
                                  .toDouble(),
                              min: 0.0,
                              max: playerState.audioPlayer.duration!.inSeconds
                                  .toDouble(),
                              onChanged: (value) {
                                playerState.audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              },
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(_formatDuration(
                            //         playerState.audioPlayer.position)),
                            //     Text(_formatDuration(
                            //         playerState.audioPlayer.duration! -
                            //             playerState.audioPlayer.position)),
                            //   ],
                            // ),
                          ],
                        ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
