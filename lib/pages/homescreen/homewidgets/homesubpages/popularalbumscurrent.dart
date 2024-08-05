import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubpagewidgets/homesubpagetitlecard.dart';

class PopularAlbumsCurrent extends StatelessWidget {
  final String albumName;
  final String artistName;
  final String imageUrl;
  const PopularAlbumsCurrent({
    super.key,
    required this.albumName,
    required this.artistName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubPageTitleCard(
                totalTracks: 20,
                subTitle: albumName,
                totalTitle: 'Tracks',
                showIcon: false,
                imagePath: imageUrl,
                showText: false,),
            alphaheight20,
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: containerWidth,
                      height: 80,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            alphawidth10,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Song Name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'LexendDeca',
                                    ),
                                  ),
                                  Text(
                                    'Artist Name',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'LexendDeca',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Transform.rotate(
                                angle: 90 * 3.1 / 180,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Broken.more,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return alphaheight10;
                  },
                  itemCount: 10),
            )
          ],
        ),
      ),
    );
  }
}
