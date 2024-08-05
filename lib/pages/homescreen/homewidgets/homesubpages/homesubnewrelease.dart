import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/widgets/popuswidgets/musicpopup/musicpopup.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubpagewidgets/homesubpagetitlecard.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomesubNewrelease extends StatelessWidget {
  final List<Map<String, String>> albums;

  const HomesubNewrelease({
    super.key,
    required this.albums,
  });

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

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
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

    final colorScheme = Theme.of(context).colorScheme;
    final totalTracks = albums.length;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubPageTitleCard(
              subTitle: 'New Release',
              totalTitle: 'Tracks',
              totalTracks: totalTracks,
              showIcon: true,
              showText: false,
            ),
            alphaheight20,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: albums.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2 / 1.5,
                ),
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return GestureDetector(
                    onTap: () => _playSong(context, album),
                    onLongPress: () {
                      _showMusicPopupDialog(
                        album['title']!,
                        album['artist']!,
                        album['image']!,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 105,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                album['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _truncateText(album['title']!, 12),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  _truncateText(album['artist']!, 12),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
