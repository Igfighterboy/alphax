import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/services/spotify_services.dart'; // Import the SpotifyService

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
        });
      }
    } catch (e) {
      print('Failed to fetch popular albums: $e');
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
              Spacer(),
              if (widget.showArrow)
                GestureDetector(
                  onTap: () {
                    print('arrow clicked');
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
        LimitedBox(
          maxHeight: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _popularAlbums.length,
            itemBuilder: (context, index) {
              final album = _popularAlbums[index];
              final imageUrl = (album['images'] != null && album['images'].isNotEmpty) ? album['images'][0]['url'] : 'https://via.placeholder.com/150';
              final albumName = album['name'] ?? 'Unknown';
              final artistName = (album['artists'] != null && album['artists'].isNotEmpty) ? album['artists'][0]['name'] : 'Unknown';

              return Padding(
                padding:
                    EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
