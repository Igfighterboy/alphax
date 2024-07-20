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

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final List<Widget> _cardTitles = [
    SearchscreenCards(),
    SearchscreenCards(),
    SearchscreenCards(),
    SearchscreenCards(),
    SearchscreenCards(),
    SearchscreenCards(),
  ];

  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  static const Duration _pageTransitionDuration =
      Duration(milliseconds: 600); // Cupertino page transition duration

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _cardTitles.length,
      (index) => AnimationController(
        duration: _pageTransitionDuration,
        vsync: this,
      ),
    );
    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1.0, 0.0), // Start position (off-screen to the right)
        end: const Offset(0.0, 0.0), // End position (on-screen)
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();

    _animateItems();
  }

  void _animateItems() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(_pageTransitionDuration ~/
          _cardTitles.length); // Adjust delay to match page transition duration
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    childAspectRatio: 1.7 / 1,
                  ),
                  itemCount: _cardTitles.length,
                  itemBuilder: (context, index) {
                    return SlideTransition(
                        position: _animations[index],
                        child: _cardTitles[index]);
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
              Get.to(
                const SearchResultScreen(),
                transition: Transition.cupertino,
                curve: Curves.easeInOut,
                duration: const Duration(
                  milliseconds: 900,
                ),
              );
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
