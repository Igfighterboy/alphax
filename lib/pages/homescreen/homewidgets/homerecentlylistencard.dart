import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';


class HomeRecentlyListenedCard extends StatefulWidget {
  final bool showArrow;
  final String homeTitle;
  final IconData homeIcon;

  const HomeRecentlyListenedCard({
    super.key,
    this.showArrow = false,
    required this.homeTitle,
    required this.homeIcon,
  });

  @override
  State<HomeRecentlyListenedCard> createState() => _HomeRecentlyListenedCardState();
}

class _HomeRecentlyListenedCardState extends State<HomeRecentlyListenedCard> {

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
                widget.homeIcon,
                color: Theme.of(context).primaryColor,
              ),
              alphawidth10,
              Text(
                widget.homeTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'LexendDeca',
                ),
              ),
              Spacer(),
              if (widget.showArrow)
                GestureDetector(
                  onTap: () {
                    print('arrow clicked');
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        ;
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 15 : 0, right: 15),
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
                                      'https://i.scdn.co/image/ab67616d0000b2735c7f0831de3b5ca077095127',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Marimazha',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'LexendDeca'),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'Vidhyasagar',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'LexendDeca'),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ],
    );
  }
}

