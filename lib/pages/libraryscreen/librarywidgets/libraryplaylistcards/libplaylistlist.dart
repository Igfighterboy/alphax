import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class LibraryplaylistList extends StatelessWidget {
  const LibraryplaylistList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey('list'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
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
                  child: GestureDetector(
                    onTap: (){},
                    child: Icon(
                      Broken.more,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
