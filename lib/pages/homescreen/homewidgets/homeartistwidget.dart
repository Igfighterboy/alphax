import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class HomeArtistCardWidget extends StatelessWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;
  const HomeArtistCardWidget({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg',
                              fit: BoxFit.cover,
                              width: 115,
                              height: 110,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            left: 55,
                            child: Container(
                              width: 73,
                              decoration: BoxDecoration(
                                color: colorScheme.primary, 
                                borderRadius: BorderRadius.circular(50)
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              child: Text(
                                'Artist',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white, // Text color
                                  fontFamily: 'LexendDeca',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Vidhyasagar',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'LexendDeca'),
                          textAlign: TextAlign.start,
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
