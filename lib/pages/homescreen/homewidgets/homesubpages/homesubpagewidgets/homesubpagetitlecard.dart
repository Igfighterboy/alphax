import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class HomeSubPageTitleCard extends StatelessWidget {
  final int totalTracks;
  final String subTitle;
  final String totalTitle;
  const HomeSubPageTitleCard({
    super.key,
    required this.totalTracks,
    required this.subTitle,
    required this.totalTitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: colorScheme.surface.withOpacity(0.58),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorScheme.surface,
                width: 3,
              ),
            ),
            child: Center(
              child: Icon(
                Broken.music,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
            ),
          ),
          alphawidth10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'LexendDeca'),
              ),
              Text(
                '$totalTitle : $totalTracks',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'LexendDeca'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
