// import 'package:flutter/material.dart';
// import 'package:myapp/controller/playercontroller/playerstate.dart';
// import 'package:provider/provider.dart';

// class FullScreenPlayer extends StatelessWidget {
//   final VoidCallback onCollapse;

//   FullScreenPlayer({required this.onCollapse});

//   @override
//   Widget build(BuildContext context) {
//     final playerState = Provider.of<PlayerState>(context);

//     return WillPopScope(
//       onWillPop: () async {
//         onCollapse();
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//             backgroundColor: Colors.red,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             title: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   onPressed: onCollapse,
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
//                         Image.network('https://w0.peakpx.com/wallpaper/662/815/HD-wallpaper-stay-calm-cr7-cristiano-football-player-portugal-real-marid-ronaldo.jpg'),

import 'package:flutter/material.dart';
import 'package:myapp/controller/playercontroller/marquee.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/playerscreen/playerwidget/waveformmain.dart';
import 'package:provider/provider.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';

class FullScreenPlayer extends StatefulWidget {
  final VoidCallback onCollapse;

  FullScreenPlayer({required this.onCollapse});

  @override
  _FullScreenPlayerState createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late ScrollController _scrollController;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          _isExpanded = false;
        });
      } else {
        setState(() {
          _isExpanded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerState = Provider.of<PlayerState>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenmHeight = MediaQuery.of(context).size.height;
    final containerWidth = screenWidth * 0.9;
    final containerHeight = screenHeight * 0.45;
    final containermHeight = screenmHeight * 0.9;
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        widget.onCollapse();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: _isExpanded ? containermHeight : 300,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (_isExpanded)
                            SongTitleandImage(
                              widget: widget,
                              containerWidth: containerWidth,
                              containerHeight: containerHeight,
                              playerState: playerState,
                            ),
                          alphaheight20,
                          playerState.audioPlayer.duration != null
                              ? Container(
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
                                      max: playerState
                                          .audioPlayer.duration!.inSeconds
                                          .toDouble(),
                                      onChanged: (value) {
                                        playerState.audioPlayer.seek(
                                            Duration(seconds: value.toInt()));
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          alphaheight20,
                          SongController(
                            colorScheme: colorScheme,
                            playerState: playerState,
                          ),
                          alphaheight20,
                          BottomController(colorScheme: colorScheme),
                          //       Column(
                          //         children: [
                          //           IconButton(
                          //             icon: Icon(
                          //               Icons.arrow_back,
                          //               color: Colors.white,
                          //             ),
                          //             onPressed: widget.onCollapse,
                          //           ),
                          //           Image.network('https://w0.peakpx.com/wallpaper/662/815/HD-wallpaper-stay-calm-cr7-cristiano-football-player-portugal-real-marid-ronaldo.jpg'),
                          //           Text('middle title', style: TextStyle(color: Colors.white)),
                          //           Text('middle subtitle', style: TextStyle(color: Colors.white)),
                          //           Row(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               IconButton(
                          //                 icon: Icon(Icons.thumb_up, color: Colors.white),
                          //                 onPressed: () {},
                          //               ),
                          //               IconButton(
                          //                 icon: Icon(Icons.pause, color: Colors.white),
                          //                 onPressed: () {},
                          //               ),
                          //               IconButton(
                          //                 icon: Icon(Icons.more_vert, color: Colors.white),
                          //                 onPressed: () {},
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                        ],
                      ),
                    ),
                  ),
                  // SliverList(
                  //   delegate: SliverChildBuilderDelegate(
                  //     (BuildContext context, int index) {
                  //       return ListTile(
                  //         title: Text('Song $index'),
                  //       );
                  //     },
                  //     childCount: 20,
                  //   ),
                  // ),
                ],
              ),
              // if (!_isExpanded)
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   right: 0,
              //   child: Material(
              //     elevation: 4.0,
              //     child: Container(
              //       height: 80,
              //       color: Colors.white,
              //       child: Row(
              //         children: [
              //           IconButton(
              //             icon: Icon(
              //               Icons.arrow_back,
              //               color: Theme.of(context).primaryColor,
              //             ),
              //             onPressed: widget.onCollapse,
              //           ),
              //           Image.network('https://w0.peakpx.com/wallpaper/662/815/HD-wallpaper-stay-calm-cr7-cristiano-football-player-portugal-real-marid-ronaldo.jpg', height: 50, width: 50),
              //           SizedBox(width: 8.0),
              //           Text('bottom title'),
              //           Spacer(),
              //           IconButton(
              //             icon: Icon(Icons.play_arrow),
              //             onPressed: () {},
              //           ),
              //           IconButton(
              //             icon: Icon(Icons.more_vert),
              //             onPressed: () {},
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // String _formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   String minutes = twoDigits(duration.inMinutes.remainder(60));
  //   String seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "$minutes:$seconds";
  // }
}

class BottomController extends StatelessWidget {
  const BottomController({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Broken.receipt_2_1,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  alphawidth10,
                  Text(
                    'Queue',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'LexendDeca',
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Broken.shuffle,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          alphawidth10,
          GestureDetector(
            onTap: () {},
            child: Icon(
              Broken.repeat,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          alphawidth10,
          GestureDetector(
            onTap: () {},
            child: Icon(
              Broken.row_vertical,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SongController extends StatelessWidget {
  const SongController({
    super.key,
    required this.colorScheme,
    required this.playerState,
  });

  final ColorScheme colorScheme;
  final PlayerState playerState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '00:00',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'LexendDeca',
                color: Theme.of(context).primaryColor),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Broken.previous,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
              IconButton(
                icon: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    playerState.audioPlayer.playing
                        ? Broken.pause
                        : Broken.play,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
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
                onPressed: () {},
                icon: Icon(
                  Broken.next,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
            ],
          ),
          Text(
            '04:59',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'LexendDeca',
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}

class SongTitleandImage extends StatelessWidget {
  const SongTitleandImage({
    super.key,
    required this.widget,
    required this.containerWidth,
    required this.containerHeight,
    required this.playerState,
  });

  final FullScreenPlayer widget;
  final double containerWidth;
  final double containerHeight;
  final PlayerState playerState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: widget.onCollapse,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Broken.arrow_down_2,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'RECOMMENDED FOR YOU',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'LexendDeca',
                ),
              ),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: Icon(
                  Broken.more,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        alphaheight20,
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Colors.red
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(playerState.thumbnailUrl,
                  fit: BoxFit.cover,
                  width: containerWidth,
                  height: containerHeight),
            ),
          ),
        ),
        alphaheight20,
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: SizedBox(
            width: containerWidth,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Marquee(
                        text: playerState.title,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'LexendDeca'),
                      ),
                      Text(
                        playerState.artist,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                    ],
                  ),
                ),
                alphawidth40,
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Broken.heart,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
