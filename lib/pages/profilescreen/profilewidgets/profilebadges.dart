import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class ProfileBadges extends StatelessWidget {
  const ProfileBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Broken.emoji_normal,
                color: Theme.of(context).primaryColor,
              ),
              alphawidth10,
              Text(
                'Bagdes',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'LexendDeca',
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          alphaheight20,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Broken.happyemoji,
                        color: Theme.of(context).primaryColor,
                      ),
                      alphawidth10,
                      Text(
                        'Alpha Family',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'LexendDeca',
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  alphaheight20,
                  Row(
                    children: [
                      Icon(
                        Broken.happyemoji,
                        color: Theme.of(context).primaryColor,
                      ),
                      alphawidth10,
                      Text(
                        'Alpha Family',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'LexendDeca',
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
