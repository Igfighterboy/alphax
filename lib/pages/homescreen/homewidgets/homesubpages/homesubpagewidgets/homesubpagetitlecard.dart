import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class SubPageTitleCard extends StatelessWidget {
  final int totalTracks;
  final String subTitle;
  final String totalTitle;
  final bool showIcon;
  final bool showText;
  final String? imagePath;
  final String? Ownertext;
  const SubPageTitleCard({
    super.key,
    required this.totalTracks,
    required this.subTitle,
    required this.totalTitle,
    required this.showIcon,
    required this.showText,
    this.imagePath,
    this.Ownertext,
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
              child: showIcon
                  ? Icon(
                      Broken.music,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    )
                  : imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imagePath!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox.shrink(),
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
              showText
                  ? Text(
                      'Owner : $Ownertext',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'LexendDeca'),
                    )
                  : SizedBox.shrink(),
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
