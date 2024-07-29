import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AboutNames(
                  containerWidth: containerWidth, colorScheme: colorScheme),
              alphaheight20,
              Container(
                width: containerWidth,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Broken.forward_item,
                              color: colorScheme.primary,
                              size: 25,
                            ),
                            alphawidth10,
                            Text(
                              'Other Platform',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    alphaheight10,
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Broken.link,
                            color: colorScheme.primary,
                            size: 25,
                          ),
                          alphawidth10,
                          Expanded(
                            child: Text(
                              'Discord',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ),
                          Icon(
                            Broken.arrow_right_2,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AboutNames extends StatelessWidget {
  const AboutNames({
    super.key,
    required this.containerWidth,
    required this.colorScheme,
  });

  final double containerWidth;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: containerWidth,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.fromLTRB(10, 56, 10, 10),
            child: Column(
              children: [
                Text(
                  'ALPhA MUSIX',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'LexendDeca',
                  ),
                ),
                Text(
                  'Where Music Comes To Your Life',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'LexendDeca',
                  ),
                ),
                Text(
                  'v2.5.2',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'LexendDeca',
                  ),
                ),
                alphaheight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                          'https://example.com/path/to/your/image.jpg'),
                    ),
                    alphawidth20,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Developer',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'LexendDeca',
                            ),
                          ),
                          Text(
                            'ELiTE DEVELOPMENT',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'LexendDeca',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Broken.scroll,
                      color: Theme.of(context).primaryColor,
                      size: 27,
                    )
                  ],
                )
              ],
            ),
          ),
          const Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 45,
              backgroundImage:
                  NetworkImage('https://example.com/path/to/your/image.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
