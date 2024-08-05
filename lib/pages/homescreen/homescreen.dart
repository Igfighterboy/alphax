import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controller/recentcontroller/played_song_services.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homewidgets/homeartistwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homebestartistwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homecarouselwidget.dart';
import 'package:myapp/pages/homescreen/homewidgets/homenewreleasecards.dart';
import 'package:myapp/pages/homescreen/homewidgets/homepopularalbumcard.dart';
import 'package:myapp/pages/homescreen/homewidgets/homerecentlylistencard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlayedSongsService _playedSongsService = PlayedSongsService();
  List<Map<String, String>> _recentlyPlayedSongs = [];
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadRecentlyPlayedSongs();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      final user = jsonDecode(userJson) as Map<String, dynamic>;
      setState(() {
        _userName = user['username'] ?? 'User';
      });
    }
  }

  Future<void> _loadRecentlyPlayedSongs() async {
    final songs = await _playedSongsService.loadPlayedSongs();
    setState(() {
      _recentlyPlayedSongs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeUserTitle(colorScheme: colorScheme, userName: _userName),
            alphaheight20,
            const HomeCarouselWidget(),
            alphaheight20,
            if (_recentlyPlayedSongs.isNotEmpty)
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
            const HomePopularSongsCard(
              homeIcon: Broken.backward_item,
              homeTitle: 'Popular albums',
              showArrow: true,
            ),
            alphaheight30,
            const HomeBestArtistWidget(
              homeIcon: Broken.category_2,
              homeTitle: 'Best Of Artist',
              showArrow: false,
            ),
            alphaheight30,
            const HomeArtistCardWidget(
              homeIcon: Broken.star_1,
              homeTitle: 'Favourite Artist',
              showArrow: false,
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
    required this.userName,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String userName; // Accept userName as a parameter

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
            userName, // Use the userName parameter
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
