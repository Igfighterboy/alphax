import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/core/constatnts/size.dart';

class LibraryStatsCard extends StatelessWidget {
  final String alphamaintitle;
  final String alphamaincount;
  final IconData alphamainIcon;
  final Color alphamaincolor;
  const LibraryStatsCard({
    super.key,
    required this.alphamaintitle,
    required this.alphamaincount,
    required this.alphamainIcon,
    required this.alphamaincolor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            Icon(
              alphamainIcon,
              color: alphamaincolor,
              size: 26,
            ),
            alphawidth10,
            Expanded(
              child: Text(
                alphamaintitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'LexendDeca',
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(
              alphamaincount,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'LexendDeca',
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
