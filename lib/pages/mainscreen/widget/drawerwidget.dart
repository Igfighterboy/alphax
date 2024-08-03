import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/core/themes/alphathemenotifier.dart';
import 'package:myapp/pages/settingsscreen/settingsscreen.dart';
import 'package:myapp/pages/signscreen/signinscreen/signinscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final AdvancedDrawerController advanceddrawerController;

  const DrawerWidget({
    required this.navigatorKey,
    required this.advanceddrawerController,
  });

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
              child: Center(
                child: Container(
                  width: 210,
                  height: 60,
                  decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: iconscolor,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      alphawidth10,
                      Text(
                        _userName, // Use _userName here
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'LexendDeca',
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, bottom: 10),
            child: Center(
              child: Container(
                width: 190,
                height: 1,
                decoration: BoxDecoration(
                    color: dividercolor,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          DrawerCardWidget(
            sideTitle: "What's New",
            sideIcon: Broken.information,
            sideButtonTap: () {
              widget.advanceddrawerController.hideDrawer();
              // widget.navigatorKey.currentState!.push(
              //   CupertinoPageRoute(builder: (context) => PostButton()),
              // );
            },
          ),
          alphaheight10,
          DrawerCardWidget(
            sideTitle: 'Listening History',
            sideIcon: Broken.clock,
            sideButtonTap: () {
              widget.advanceddrawerController.hideDrawer();
              // widget.navigatorKey.currentState!.push(
              //   CupertinoPageRoute(builder: (context) => PostButton()),
              // );
            },
          ),
          alphaheight10,
          DrawerCardWidget(
            sideTitle: "Settings",
            sideIcon: Broken.setting_2,
            sideButtonTap: () {
              widget.advanceddrawerController.hideDrawer();
              widget.navigatorKey.currentState!.push(
                CupertinoPageRoute(
                  builder: (context) =>
                      SettingsScreen(navigatorKey: widget.navigatorKey),
                ),
              );
            },
          ),
          alphaheight10,
          DrawerCardWidget(
            sideTitle: "Logout",
            sideIcon: Broken.setting_2,
            sideButtonTap: () async {
              widget.advanceddrawerController.hideDrawer();
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('user');
              await prefs.remove('userToken');
              widget.navigatorKey.currentState!.pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 135,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              DrawerCardWidget(
                sideTitle: 'Sleep Timer',
                sideIcon: Broken.timer_1,
                sideButtonTap: () {},
              ),
              alphaheight10,
              const ThemeTabs(
                  themeWidth: 61,
                  themeHeight: 35,
                  themecontainerWidth: 210,
                  themeLeft: 70.0),
            ],
          ),
        ),
      ),
    );
  }
}


class DrawerCardWidget extends StatelessWidget {
  final VoidCallback sideButtonTap;
  final String sideTitle;
  final IconData sideIcon;
  const DrawerCardWidget({
    super.key,
    required this.sideButtonTap,
    required this.sideTitle,
    required this.sideIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: GestureDetector(
        onTap: sideButtonTap,
        child: Container(
          width: 210,
          height: 50,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  sideIcon,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
                alphawidth10,
                Text(
                  sideTitle,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'LexendDeca'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeTabs extends StatelessWidget {
  final double themeWidth;
  final double themecontainerWidth;
  final double themeHeight;
  final double themeLeft;
  const ThemeTabs({
    super.key,
    required this.themeWidth,
    required this.themecontainerWidth,
    required this.themeHeight,
    required this.themeLeft,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final double _alphathemewidth = themeWidth;
    final double _alphathemeheight = themeHeight;
    final BorderRadius _alphathemeradius = BorderRadius.circular(10);
    int selectedIndex;
    switch (themeNotifier.themeMode) {
      case ThemeModeType.system:
        selectedIndex = 0;
        break;
      case ThemeModeType.light:
        selectedIndex = 1;
        break;
      case ThemeModeType.dark:
        selectedIndex = 2;
        break;
      default:
        selectedIndex = 0;
        break;
    }

    return Container(
      width: themecontainerWidth,
      height: 50,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: selectedIndex * themeLeft,
              top: 7,
              child: Container(
                height: _alphathemeheight,
                width: _alphathemewidth,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: _alphathemeradius,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      themeNotifier.switchTheme(ThemeModeType.system);
                    },
                    child: Container(
                      height: _alphathemeheight,
                      width: _alphathemewidth,
                      decoration: BoxDecoration(
                        borderRadius: _alphathemeradius,
                      ),
                      child: Icon(
                        Broken.autobrightness,
                        color: selectedIndex == 0
                            ? iconscolor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      themeNotifier.switchTheme(ThemeModeType.light);
                    },
                    child: Container(
                      height: _alphathemeheight,
                      width: _alphathemewidth,
                      decoration: BoxDecoration(
                        borderRadius: _alphathemeradius,
                      ),
                      child: Icon(Broken.sun_1,
                          color: selectedIndex == 1
                              ? iconscolor
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      themeNotifier.switchTheme(ThemeModeType.dark);
                    },
                    child: Container(
                      height: _alphathemeheight,
                      width: _alphathemewidth,
                      decoration: BoxDecoration(
                        borderRadius: _alphathemeradius,
                      ),
                      child: Icon(
                        Broken.moon,
                        color: selectedIndex == 2
                            ? iconscolor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
