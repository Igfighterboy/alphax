import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/mainscreen/widget/drawerwidget.dart';

class SettingsThemePage extends StatefulWidget {
  const SettingsThemePage({super.key});

  @override
  State<SettingsThemePage> createState() => _SettingsThemePageState();
}

class _SettingsThemePageState extends State<SettingsThemePage> {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: containerWidth,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Broken.brush_2,
                        color: colorScheme.primary,
                        size: 32,
                      ),
                      alphawidth10,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theme',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'LexendDeca,'),
                          ),
                          Text(
                            'Overall theme of the app',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'LexendDeca,'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  alphaheight10,
                  Container(
                    width: 250,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  alphaheight20,
                  Row(
                    children: [
                      Icon(
                        Broken.brush_4,
                        color: colorScheme.primary,
                        size: 30,
                      ),
                      alphawidth10,
                      Expanded(
                        child: Text(
                          'Theme Mode',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontFamily: 'LexendDeca',
                          ),
                        ),
                      ),
                      const ThemeTabs(
                        themeWidth: 40,
                        themeHeight: 35,
                        themecontainerWidth: 160,
                        themeLeft: 55,
                      ),
                    ],
                  ),
                  alphaheight10,
                  Row(
                    children: [
                      Icon(
                        Broken.bucket,
                        color: colorScheme.primary,
                        size: 30,
                      ),
                      alphawidth10,
                      Expanded(
                        child: Text(
                          'Active Color',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontFamily: 'LexendDeca',
                          ),
                        ),
                      ),
                    ],
                  ),
                  alphaheight20,
                  Row(
                    children: [
                      Icon(
                        Broken.maximize_2,
                        color: colorScheme.primary,
                        size: 30,
                      ),
                      alphawidth10,
                      Expanded(
                        child: Text(
                          'Container Radius',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontFamily: 'LexendDeca',
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
    );
  }
}



