import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class HomeMusicCards extends StatelessWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;
  const HomeMusicCards({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              homeIcon,
              color: Theme.of(context).primaryColor,
            ),
            alphawidth10,
            Text(
              homeTitle,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                fontFamily: 'LexendDeca',
              ),
            ),
            Spacer(),
            if (showArrow)
              GestureDetector(
                onTap: () {
                  print('aroow clicked');
                },
                child: Icon(
                  Broken.arrow_right_3,
                  color: Theme.of(context).primaryColor,
                ),
              ),
          ],
        ),

        // SONG CARDS
        alphaheight20,
        LimitedBox(
          maxHeight: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 115,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5sEMZNhfvjWTFa5QdIrKO1ZlXyVlWPNXdmg&s',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marimazha',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'LexendDeca'),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              'Song • Karthik',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'LexendDeca'),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
