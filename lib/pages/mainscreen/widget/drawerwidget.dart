import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/testingpage.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final AdvancedDrawerController advanceddrawerController;

  const DrawerWidget({
    required this.navigatorKey,
    required this.advanceddrawerController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 5, right: 5),
              child: Center(
                child: Container(
                  width: 210,
                  height: 100,
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
                              color: Theme.of(context).primaryColor,
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
                        'UserName',
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
              advanceddrawerController.hideDrawer();
              navigatorKey.currentState!.push(
                CupertinoPageRoute(builder: (context) => TestingPage()),
              );
            },
          ),
          alphaheight10,
          DrawerCardWidget(
            sideTitle: 'Listening History',
            sideIcon: Broken.clock,
            sideButtonTap: () {
              advanceddrawerController.hideDrawer();
              navigatorKey.currentState!.push(
                CupertinoPageRoute(builder: (context) => TestingPage()),
              );
            },
          ),
          alphaheight10,
          DrawerCardWidget(
            sideTitle: "What's New",
            sideIcon: Broken.setting_2,
            sideButtonTap: () {
              advanceddrawerController.hideDrawer();
              navigatorKey.currentState!.push(
                CupertinoPageRoute(builder: (context) => TestingPage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const SizedBox(
        height: 140,
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              // DrawerCardWidget(
              //     sideTitle: 'Sleep Timer', sideIcon: Broken.timer_1),
              // alphaheight10,
              // DrawerCardWidget(
              //     sideTitle: 'Sleep Timer', sideIcon: Broken.timer_1),
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
