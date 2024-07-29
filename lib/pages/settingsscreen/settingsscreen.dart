import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/settingsscreen/subpages/settingsabout.dart';
import 'package:myapp/pages/settingsscreen/subpages/settingstheme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.navigatorKey,
  });
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: containerWidth,
            decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Column(
                children: [
                  SettingsButtons(
                    colorScheme: colorScheme,
                    settingsicon: Broken.brush_2,
                    settingstitle: 'Theme',
                    settingssubtitle: 'Overall theme of the app',
                    navigatorKey: navigatorKey,
                    settingsontap: () {
                      navigatorKey.currentState!.push(
                        CupertinoPageRoute(
                            builder: (context) => SettingsThemePage()),
                      );
                    },
                  ),
                  alphaheight10,
                  SettingsButtons(
                    colorScheme: colorScheme,
                    settingsicon: Broken.info_circle,
                    settingstitle: 'About',
                    settingssubtitle: 'Information about app',
                    navigatorKey: navigatorKey,
                    settingsontap: () {
                      navigatorKey.currentState!.push(
                        CupertinoPageRoute(
                            builder: (context) => SettingsAbout()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsButtons extends StatelessWidget {
  final ColorScheme colorScheme;
  final IconData settingsicon;
  final String settingstitle;
  final String settingssubtitle;
  final VoidCallback settingsontap;
  final GlobalKey<NavigatorState> navigatorKey;

  const SettingsButtons({
    super.key,
    required this.colorScheme,
    required this.settingsicon,
    required this.settingstitle,
    required this.settingssubtitle,
    required this.settingsontap,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: settingsontap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove the padding
      ),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  settingsicon,
                  size: 30,
                  color: colorScheme.primary,
                ),
                alphawidth10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        settingstitle,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontFamily: 'LexendDeca'),
                      ),
                      Text(
                        settingssubtitle,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Broken.arrow_right_3,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
