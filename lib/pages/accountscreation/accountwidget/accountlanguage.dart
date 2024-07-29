import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class LanguageContainer extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onSelect;

  const LanguageContainer({
    Key? key,
    required this.language,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Broken.language_square,
                    color: iconscolor,
                  ),
                ),
                if (isSelected)
                 Icon(
                    Broken.tick_circle,
                    color: iconscolor,
                  ),
              ],
            ),
            Text(
                  language,
                  style: TextStyle(
                    color: isSelected ? iconscolor : Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
