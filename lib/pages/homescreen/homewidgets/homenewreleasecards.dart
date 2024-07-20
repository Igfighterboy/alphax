import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubnewrelease.dart';
import 'package:myapp/services/spotify_services.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final SpotifyService _spotifyService = SpotifyService();
  final AlbumCache _albumCache = AlbumCache();
  bool isLoading = true;
  bool hasFetched = false;

  @override
  void initState() {
    super.initState();
    if (!_albumCache.isFetched) {
      fetchnewRelease();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchnewRelease() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedAlbums = await _spotifyService.fetchNewReleases();
      setState(() {
        _albumCache.albums = fetchedAlbums.map<Map<String, String>>((album) {
          final albumImages = album['images'] as List<dynamic>?;
          final artistNames = (album['artists'] as List<dynamic>?)
              ?.map((artist) => artist['name'] as String?)
              .where((name) => name != null)
              .join(', ');

          return {
            'title': album['name'] ?? 'Unknown Title',
            'artist': artistNames ?? 'Unknown Artist',
            'image': (albumImages != null && albumImages.isNotEmpty)
                ? albumImages[0]['url'] as String
                : 'https://via.placeholder.com/150',
            'spotifyUri': album['uri'] ?? '', // Add the Spotify URI
          };
        }).toList();
        _albumCache.isFetched = true;
        isLoading = false;
        hasFetched = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  void _launchSpotify(String albumId) async {
    final url = 'spotify:album:$albumId';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching Spotify URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 10),
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
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => HomesubNewrelease()));
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
        SizedBox(height: 20),
        LimitedBox(
          maxHeight: 150,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _albumCache.albums.length,
                  itemBuilder: (context, index) {
                    final album = _albumCache.albums[index];
                    return GestureDetector(
                      onTap: () => _launchSpotify(album['spotifyUri']!),
                      child: Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
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
