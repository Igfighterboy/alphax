import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubpopularalbums.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/popularalbumscurrent.dart';
import 'package:myapp/services/spotify_services.dart';
import 'package:shimmer/shimmer.dart';

class HomePopularSongsCard extends StatefulWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;

  const HomePopularSongsCard({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  State<HomePopularSongsCard> createState() => _HomePopularSongsCardState();
}

class _HomePopularSongsCardState extends State<HomePopularSongsCard> {
  List<Map<String, dynamic>> _popularAlbums = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPopularAlbums();
  }

  Future<void> _fetchPopularAlbums() async {
    try {
      final spotifyService = SpotifyService();
      final albums = await spotifyService.fetchPopularAlbums();
      if (mounted) {
        setState(() {
          _popularAlbums = albums;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Failed to fetch popular albums: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
              const Spacer(),
              if (widget.showArrow)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => HomePopularalbumsSubPage(
                          popularAlbums: _popularAlbums,
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
        alphaheight20,
        _isLoading
            ? LimitedBox(
                maxHeight: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Number of shimmer items to display
                  itemBuilder: (context, index) {
                    final colorScheme = Theme.of(context).colorScheme;
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                      child: Shimmer.fromColors(
                        baseColor: colorScheme.secondary,
                        highlightColor: colorScheme.surface,
                        child: Container(
                          width: 115,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 10,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      height: 10,
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
              )
            : _popularAlbums.isEmpty
                ? Center(
                    child: Text(
                      'No popular albums found.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'LexendDeca',
                      ),
                    ),
                  )
                : LimitedBox(
                    maxHeight: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _popularAlbums.length,
                      itemBuilder: (context, index) {
                        final album = _popularAlbums[index];
                        final imageUrl =
                            (album['images'] != null && album['images'].isNotEmpty)
                                ? album['images'][0]['url']
                                : 'https://via.placeholder.com/150';
                        final albumName = album['name'] ?? 'Unknown';
                        final artistName =
                            (album['artists'] != null && album['artists'].isNotEmpty)
                                ? album['artists'][0]['name']
                                : 'Unknown';

                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => PopularAlbumsCurrent(
                                    albumName: albumName,
                                    artistName: artistName,
                                    imageUrl: imageUrl,
                                  ),
                                ),
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
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        imageUrl,
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
                                          albumName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).primaryColor,
                                            fontFamily: 'LexendDeca',
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          artistName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).primaryColor,
                                            fontFamily: 'LexendDeca',
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
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
