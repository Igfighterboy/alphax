import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubpagewidgets/homesubpagetitlecard.dart';

class HomePopularalbumsSubPage extends StatelessWidget {
  List<Map<String, dynamic>> popularAlbums = [];
  HomePopularalbumsSubPage({
    super.key,
    required this.popularAlbums,
  });

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final totalAlbums = popularAlbums.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubPageTitleCard(
              totalTracks: totalAlbums,
              subTitle: 'Popular Albums',
              totalTitle: 'Albums',
              showIcon: true,
              showText: false,
            ),
            alphaheight20,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: popularAlbums.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2 / 1.5,
                ),
                itemBuilder: (context, index) {
                  final album = popularAlbums[index];
                  final imageUrl =
                      (album['images'] != null && album['images'].isNotEmpty)
                          ? album['images'][0]['url']
                          : 'https://via.placeholder.com/150';
                  final albumName = album['name'] ?? 'Unknown';
                  final artistName =
                      (album['artists'] != null && album['artists'].isNotEmpty)
                          ? album['artists'][0]['name']
                          : 'Unknown';
                  return GestureDetector(
                    onTap: () {},
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
                                imageUrl,
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
                                  _truncateText(albumName, 12),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  _truncateText(artistName, 10),
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
