import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class LibraryplaylistList extends StatelessWidget {
  final VoidCallback onMoreTap;
  final VoidCallback onPlaylistTap;
  const LibraryplaylistList({
    super.key,
    required this.onMoreTap,
    required this.onPlaylistTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey('list'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return TextButton(
          onPressed: onPlaylistTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 65,
                          height: 65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              'https://picsum.photos/200/300',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alphawidth10,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Playlist Name',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                            Text(
                              'playlist * 10 Track',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Transform.rotate(
                    angle: 90 * 3.1 / 180,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: onMoreTap,
                      child: Icon(
                        Broken.more,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
