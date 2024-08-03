import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/core/widgets/popuswidgets/musicpopup/musicpopup.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubnewrelease.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class HomeNewReleaseCard extends StatefulWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;

  const HomeNewReleaseCard({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  State<HomeNewReleaseCard> createState() => _HomeNewReleaseCardState();
}

class _HomeNewReleaseCardState extends State<HomeNewReleaseCard> {
  final YoutubeService _youtubeService = YoutubeService();
  final AlbumCache _albumCache = AlbumCache();
  bool isLoading = true;
  bool hasFetched = false;

  @override
  void initState() {
    super.initState();
    if (!_albumCache.isFetched) {
      fetchNewRelease();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchNewRelease() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final fetchedAlbums =
          await _youtubeService.fetchNewReleases('Malayalam New Release Music');
      if (mounted) {
        setState(() {
          _albumCache.albums = fetchedAlbums;
          _albumCache.isFetched = true;
          isLoading = false;
          hasFetched = true;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  void _playSong(BuildContext context, Map<String, String> album) async {
    final playerState = Provider.of<PlayerState>(context, listen: false);
    final youtubeExplode = YoutubeExplode();
    try {
      var video = await youtubeExplode.videos.get(album['videoUrl']!);
      var manifest =
          await youtubeExplode.videos.streamsClient.getManifest(video.id);
      var audioStreamInfo = manifest.audioOnly.withHighestBitrate();
      var audioUrl = audioStreamInfo.url.toString();

      playerState.play(
          album['title']!, album['artist']!, album['image']!, audioUrl);
    } catch (e) {
      print('Error playing song: $e');
    } finally {
      youtubeExplode.close();
    }
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

    // Filter albums to exclude those without thumbnails
    final List<Map<String, String>> albumsWithThumbnails = _albumCache.albums
        .where((album) => album['image'] != null && album['image']!.isNotEmpty)
        .toList();

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
              const SizedBox(width: 10),
              Text(
                widget.homeTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'LexendDeca',
                ),
              ),
              const Spacer(),
              if (widget.showArrow)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => HomesubNewrelease(
                          albums: albumsWithThumbnails,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Broken.arrow_right_3,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
        // SONG CARDS
        const SizedBox(height: 20),

        LimitedBox(
          maxHeight: 150,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Number of shimmer placeholders
                  itemBuilder: (context, index) {
                    final colorScheme = Theme.of(context).colorScheme;
                    return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                      child: Shimmer.fromColors(
                        baseColor: colorScheme.secondary,
                        highlightColor: colorScheme.surface,
                        child: Container(
                          width: 115,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 105,
                                width: 115,
                                color: Colors.grey.shade300,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 12,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 60,
                                      height: 12,
                                      color: Colors.grey.shade300,
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
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: albumsWithThumbnails.length,
                  itemBuilder: (context, index) {
                    final album = albumsWithThumbnails[index];
                    return GestureDetector(
                      onTap: () => _playSong(context, album),
                      onLongPress: () {
                        _showMusicPopupDialog(
                          album['title']!,
                          album['artist']!,
                          album['image']!,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 15 : 0, right: 15),
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
                                    album['image']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _truncateText(album['title']!, 12),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: 'LexendDeca',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      _truncateText(album['artist']!, 10),
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
}

class AlbumCache {
  static final AlbumCache _instance = AlbumCache._internal();

  factory AlbumCache() {
    return _instance;
  }

  AlbumCache._internal();

  List<Map<String, String>> albums = [];
  bool isFetched = false;
}
