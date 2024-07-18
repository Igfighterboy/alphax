import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/searchscreen/searchresultscreen.dart';
import 'package:myapp/pages/searchscreen/searchwidget/searchscreencards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  final List<String> _cardTitles = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
    'Card 6',
  ];

  late List<bool> _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = List.filled(_cardTitles.length, false);
    _animateItems();
  }

  void _animateItems() async {
    for (int i = 0; i < _cardTitles.length; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _isVisible[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Searchbar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2 / 1,
                  ),
                  itemCount: _cardTitles.length,
                  itemBuilder: (context, index) {
                    return AnimatedOpacity(
                      opacity: _isVisible[index] ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Card(
                        elevation: 4,
                        child: Center(
                          child: Text(
                            _cardTitles[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(SearchResultScreen(),
                  transition: Transition.cupertino,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 900));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                children: [
                  Icon(
                    Broken.search_normal,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  alphawidth10,
                  Text(
                    'Search for songs or artists',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'LexandDeca',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
