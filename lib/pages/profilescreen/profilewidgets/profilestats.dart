import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class ProfileStatsWidget extends StatelessWidget {
  const ProfileStatsWidget({super.key});

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
                Broken.personalcard,
                color: Theme.of(context).primaryColor,
              ),
              alphawidth10,
              Text(
                'Stats',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'LexendDeca',
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          alphaheight20,
          GridView.builder(
            key: const ValueKey('grid'),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 1.13,
            ),
            itemBuilder: (context, index) {
              return profileStats(colorScheme: colorScheme);
            },
          ),
        ],
      ),
    );
  }
}

class profileStats extends StatelessWidget {
  const profileStats({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 33,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'LexendDeca',
                  ),
                ),
                alphawidth10,
                Text(
                  'Minutes',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'LexendDeca',
                  ),
                ),
              ],
            ),
            alphaheight10,
            Text(
                  'Listened to music',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'LexendDeca',
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
