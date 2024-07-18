import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homewidgets/homeartistwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homebestartistwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homecarouselwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homenewreleasecards.dart';
import 'package:myapp/pages/homescreen/homewidgets/homepopularalbumcard.dart';
import 'package:myapp/pages/homescreen/homewidgets/homerecentlylistencard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeUserTitle(colorScheme: colorScheme),
            alphaheight20,
            const HomeCarouselWidget(),
            alphaheight20,
            const HomeRecentlyListenedCard(
              homeIcon: Broken.command_square,
              homeTitle: 'Recent Listened',
              showArrow: false,
            ),
            alphaheight30,
            const HomeNewReleaseCard(
              homeIcon: Broken.crown_1,
              homeTitle: 'New Releases',
              showArrow: true,
            ),
            alphaheight30,
            const HomeArtistCardWidget(
              homeIcon: Broken.star_1,
              homeTitle: 'Favourite Artist',
              showArrow: false,
            ),
            alphaheight30,
            const HomeBestArtistWidget(
              homeIcon: Broken.category_2,
              homeTitle: 'Best Of Artist',
              showArrow: true,
            ),
            alphaheight30,
            const HomePopularSongsCard(
              homeIcon: Broken.backward_item,
              homeTitle: 'Popular albums',
              showArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeUserTitle extends StatelessWidget {
  const HomeUserTitle({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey ,',
            style: TextStyle(
              fontFamily: 'LexendDeca',
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            'UserName',
            style: TextStyle(
              fontFamily: 'LexendDeca',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
