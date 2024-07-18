import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';

class SearchscreenCards extends StatelessWidget {
  const SearchscreenCards({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double alphasWidth = screenWidth * 0.40;
    final double alphasheight = 110;
    final colorScheme = Theme.of(context).colorScheme;
    final Color alphacardcolor = colorScheme.surface;
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: alphasWidth,
            height: alphasheight,
            decoration: BoxDecoration(
              color: alphacardcolor,
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          alphawidth10,
          Container(
            width: alphasWidth,
            height: alphasheight,
            decoration: BoxDecoration(
              color: alphacardcolor,
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ],
      ),
    );
  }
}
