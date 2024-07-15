import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homewidgets/homeartistwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homecarouselwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homemusiccards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeUserTitle(colorScheme: colorScheme),
              alphaheight20,
              const HomeCarouselWidget(),
              alphaheight20,
              const HomeMusicCards(
                homeIcon: Broken.command_square,
                homeTitle: 'Recent Listened',
                showArrow: false,
              ),
              alphaheight30,
              const HomeMusicCards(
                homeIcon: Broken.crown_1,
                homeTitle: 'New Releases',
                showArrow: true,
              ),
              alphaheight30,
              HomeArtistCardWidget(
                homeIcon: Broken.star_1,
                homeTitle: 'Favourite Artist',
                showArrow: true,
              ),
              alphaheight30,
              const HomeMusicCards(
                homeIcon: Broken.backward_item,
                homeTitle: 'Popular albums',
                showArrow: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeUserTitle extends StatelessWidget {
  const HomeUserTitle({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}




// Center(
//         child: ElevatedButton(
//           onPressed: () {
//           Navigator.of(context).push(
//             CupertinoPageRoute(builder: (context) => TestingPage()),
//           );
//         },
//           child: Text('Go to Home Detail'),
//         ),
//       ),