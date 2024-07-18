import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class HomeBestArtistWidget extends StatelessWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;
  const HomeBestArtistWidget({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
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
              const Spacer(),
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
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
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
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg',
                              fit: BoxFit.cover,
                              width: 115,
                              height: 150,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 115,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                   borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              child: Column(
                                children: [
                                   Text(
                                    'Best Of',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor, // Text color
                                      fontFamily: 'LexendDeca',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                   Text(
                                    'Vidhyasagar',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor, // Text color
                                      fontFamily: 'LexendDeca',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
