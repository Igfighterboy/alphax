import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:provider/provider.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:myapp/controller/playercontroller/marquee.dart'; 

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
    _timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (
      timer,
    ) {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 1;
    return Consumer<PlayerState>(
      builder: (context, playerState, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: GestureDetector(
            onTap: widget.onExpand,
            child: Container(
              width: containerWidth,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorScheme.surface,
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  Row(
                    children: [
                      // Thumbnail and song info
                      Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            playerState.thumbnailUrl,
                            width: 43,
                            height: 43,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alphawidth10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Marquee(
                              text: playerState.title,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'LexendDeca'),
                            ),
                            Text(
                              playerState.artist,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ],
                        ),
                      ),
                      alphawidth10,
                      IconButton(
                        icon: Icon(
                          playerState.audioPlayer.playing
                              ? Broken.pause
                              : Broken.play,
                          color: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  playerState.audioPlayer.duration != null
                      ? Positioned(
                          bottom: -24,
                          left: -18,
                          child: Container(
                            width: containerWidth,
                            height: 50,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: SliderComponentShape.noThumb,
                                activeTrackColor: colorScheme.primary,
                                inactiveTrackColor: Colors.transparent,
                              ),
                              child: Slider(
                                value: playerState
                                    .audioPlayer.position.inSeconds
                                    .toDouble(),
                                min: 0.0,
                                max: playerState.audioPlayer.duration!.inSeconds
                                    .toDouble(),
                                onChanged: (value) {
                                  playerState.audioPlayer
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // String _formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   String minutes = twoDigits(duration.inMinutes.remainder(60));
  //   String seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "$minutes:$seconds";
  // }
}
