import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class SearchscreenCards extends StatelessWidget {
  const SearchscreenCards({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Broken.music,
                color: Theme.of(context).primaryColor,
              ),
            ),
            alphaheight10,
            SizedBox(
              width: double.infinity,
                child: Text(
              'Malayalam',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'LexendDeca',
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.end,
            ))
          ],
        ),
      ),
    );
  }
}
