import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/accountscreation/accountwidget/accountartist.dart';
import 'package:myapp/pages/accountscreation/accountwidget/accountlanguage.dart';
import 'package:myapp/pages/mainscreen/mainscreen.dart';

class AccountCreation extends StatefulWidget {
  @override
  _AccountCreationState createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  int step = 1;
  int maxSelectableLanguages = 3;
  int minSelectableLanguages = 2;
  int maxSelectableArtists = 5;
  int minSelectableArtists = 3;
  List<String> selectedLanguages = [];
  List<String> selectedArtists = [];

  final List<String> availableLanguages = [
    'Malayalam',
    'Tamil',
    'Hindi',
    'Punjabi',
    'Telugu',
    'Marathi',
    'Bengali',
    'International',
    'Gujarati',
    'Kannada',
  ];
  final Map<String, List<Map<String, String>>> artistsByLanguage = {
    'Malayalam': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Tamil': [
      {
        'name': 'Artist2',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Hindi': [
      {
        'name': 'Artist3',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Punjabi': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Telugu': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Marathi': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Bengali': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'International': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Gujarati': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
    'Kannada': [
      {
        'name': 'Artist1',
        'image':
            'https://i.pinimg.com/originals/b1/ff/d8/b1ffd8135ff9bff3795c6166327399ee.jpg'
      },
    ],
  };

  void nextStep() {
    if (step == 1 && selectedLanguages.length >= minSelectableLanguages) {
      setState(() {
        step++;
      });
    } else if (step == 2 && selectedArtists.length >= minSelectableArtists) {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
    }
  }

  void toggleArtistSelection(String artist) {
    setState(() {
      if (selectedArtists.contains(artist)) {
        selectedArtists.remove(artist);
      } else {
        if (selectedArtists.length < maxSelectableArtists) {
          selectedArtists.add(artist);
        }
      }
    });
  }

  void toggleLanguageSelection(String language) {
    setState(() {
      if (selectedLanguages.contains(language)) {
        selectedLanguages.remove(language);
      } else {
        if (selectedLanguages.length < maxSelectableLanguages) {
          selectedLanguages.add(language);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: step == 1 ? buildLanguageSelection() : buildArtistSelection(),
        ),
      ),
    );
  }

  Widget buildLanguageSelection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick Your Music Language',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'LexendDeca',
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          'Choose at Least 2 Languages for Best Experience',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'LexendDeca',
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor,
          ),
        ),
        alphaheight20,
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: availableLanguages.length,
            itemBuilder: (context, index) {
              final language = availableLanguages[index];
              return LanguageContainer(
                language: language,
                isSelected: selectedLanguages.contains(language),
                onSelect: () {
                  toggleLanguageSelection(language);
                },
              );
            },
          ),
        ),
        if (selectedLanguages.length >= minSelectableLanguages)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: nextStep,
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          color: iconscolor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                      alphawidth10,
                      Icon(
                        Broken.arrow_right_3,
                        color: iconscolor,
                        size: 17,
                      )
                    ],
                  ),
                )),
          ),
      ],
    );
  }

  Widget buildArtistSelection() {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: selectedLanguages.length + 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick Your Favorite Artists',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'LexendDeca',
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            'Choose at Least 3 Artists',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'LexendDeca',
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
          ),
          alphaheight10,
          SizedBox(
            height: 40,
            child: TabBar(
              isScrollable: true,
              indicator: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
              unselectedLabelColor: Theme.of(context).primaryColor,
              labelColor: iconscolor,
              labelStyle: const TextStyle(
                fontSize: 13.5,
                fontFamily: 'LexendDeca',
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                const Tab(
                  text: 'All Artists',
                ),
                ...selectedLanguages.map((lang) => Tab(text: lang)).toList(),
              ],
            ),
          ),
          alphaheight10,
          Container(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          alphaheight10,
          Expanded(
            child: TabBarView(
              children: [
                buildArtistsGrid(
                    artistsByLanguage.values.expand((x) => x).toList()),
                ...selectedLanguages
                    .map((lang) =>
                        buildArtistsGrid(artistsByLanguage[lang] ?? []))
                    .toList(),
              ],
            ),
          ),
          if (selectedArtists.length >= minSelectableArtists)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: nextStep,
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Done',
                        style: TextStyle(
                          color: iconscolor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                      alphawidth10,
                      Icon(
                        Broken.arrow_right_3,
                        color: iconscolor,
                        size: 17,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildArtistsGrid(List<Map<String, String>> artists) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ArtistContainer(
          artist: artist['name']!,
          image: artist['image']!,
          isSelected: selectedArtists.contains(artist['name']),
          onSelect: () {
            toggleArtistSelection(artist['name']!);
          },
        );
      },
    );
  }
}
