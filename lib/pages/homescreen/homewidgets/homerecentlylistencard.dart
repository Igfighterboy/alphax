import 'package:flutter/material.dart';
import 'package:myapp/controller/recentcontroller/played_song_services.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/core/widgets/popuswidgets/musicpopup/musicpopup.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';

class HomeRecentlyListenedCard extends StatefulWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;

  const HomeRecentlyListenedCard({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  State<HomeRecentlyListenedCard> createState() =>
      _HomeRecentlyListenedCardState();
}

class _HomeRecentlyListenedCardState extends State<HomeRecentlyListenedCard> {
  final PlayedSongsService _playedSongsService = PlayedSongsService();
  List<Map<String, String>> _recentlyPlayedSongs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentlyPlayedSongs();
  }

  Future<void> _loadRecentlyPlayedSongs() async {
    final songs = await _playedSongsService.loadPlayedSongs();
    setState(() {
      _recentlyPlayedSongs = songs;
      _isLoading = false;
    });
  }

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  void _playSong(Map<String, String> song) {
    final playerState = Provider.of<PlayerState>(context, listen: false);
    // Implement the play functionality here
    playerState.play(
      song['title']!,
      song['artist']!,
      song['thumbnailUrl']!,
      song['audioUrl']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showMusicPopupDialog(
        String currenttitle, String currentartist, String currentthumbnail) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MusicPopup(
            currenttitle: currenttitle,
            currentartist: currentartist,
            currentthumbnail: currentthumbnail,
            onAddToLikedSongs: () {
              print('clicked on Liked button');
            },
            onAddToPlaylist: () {
              print('clicked on Playlist button');
            },
            onAddToQueue: () {
              print('clicked on queue button');
            },
            onGoToAlbum: () {
              print('clicked on Album button');
            },
            onShare: () {
              print('clicked on Share button');
            },
            onGoToArtist: () {
              print('clicked on Artist button');
            },
          );
        },
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.homeIcon,
                color: Theme.of(context).primaryColor,
              ),
              alphawidth10,
              Text(
                widget.homeTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'LexendDeca',
                ),
              ),
              Spacer(),
              if (widget.showArrow)
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Broken.arrow_right_3,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
        alphaheight20,
        _isLoading
            ? _buildShimmerPlaceholder()
            : LimitedBox(
                maxHeight: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recentlyPlayedSongs.length,
                  itemBuilder: (context, index) {
                    final song = _recentlyPlayedSongs[index];
                    if (song['thumbnailUrl'] == null || song['thumbnailUrl']!.isEmpty) {
                      return SizedBox.shrink(); // Skip songs with no thumbnail
                    }
                    return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                      child: GestureDetector(
                        onTap: () => _playSong(song),
                        onLongPress: () {
                          _showMusicPopupDialog(
                            song['title']!,
                            song['artist']!,
                            song['thumbnailUrl']!,
                          );
                        },
                        child: Container(
                          width: 115,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 105,
                                width: 115,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    song['thumbnailUrl']!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade300,
                                        child: Center(
                                          child: Icon(
                                            Icons.music_note,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _truncateText(song['title']!, 12),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: 'LexendDeca',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      _truncateText(song['artist']!, 10),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: 'LexendDeca',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildShimmerPlaceholder() {
    final colorScheme = Theme.of(context).colorScheme;

    return LimitedBox(
      maxHeight: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
            child: Shimmer.fromColors(
              baseColor: colorScheme.secondary,
              highlightColor: colorScheme.surface,
              child: Container(
                width: 115,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 105,
                      width: 115,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12,
                            width: 70,
                            color: Colors.grey[300],
                          ),
                          alphaheight10,
                          Container(
                            height: 12,
                            width: 50,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
