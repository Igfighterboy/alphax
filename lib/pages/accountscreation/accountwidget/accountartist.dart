import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';

class ArtistContainer extends StatelessWidget {
  final String artist;
  final String image;
  final bool isSelected;
  final VoidCallback onSelect;

  const ArtistContainer({
    Key? key,
    required this.artist,
    required this.image,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  artist,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isSelected ? iconscolor : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // child: Container(
      //   // margin: EdgeInsets.symmetric(vertical: 8.0),
      //   // padding: EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   color: isSelected ? Colors.blue : Colors.grey[200],
      //   borderRadius: BorderRadius.circular(8.0),
      //   border: Border.all(color: Colors.black12),
      // ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Image.network(image, height: 50, width: 50, fit: BoxFit.cover),
      //       Text(
      //         artist,
      //         style: TextStyle(
      //           color: isSelected ? Colors.white : Colors.black,
      //           fontSize: 18,
      //         ),
      //       ),
      //       if (isSelected)
      //         Icon(
      //           Icons.check_circle,
      //           color: Colors.white,
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
