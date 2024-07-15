import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselWidget extends StatefulWidget {
  const HomeCarouselWidget({
    super.key,
  });

  @override
  State<HomeCarouselWidget> createState() => _HomeCarouselWidgetState();
}

class _HomeCarouselWidgetState extends State<HomeCarouselWidget> {
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCOOfz8FzFXvu4eJBp7w5KSk2sGBQcvKKXWBMmaR-OZb3ioldabD7fu1QeRTs_pp1Rwg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCOOfz8FzFXvu4eJBp7w5KSk2sGBQcvKKXWBMmaR-OZb3ioldabD7fu1QeRTs_pp1Rwg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjOnYEhf7PDJIvd6mdDyn0IzjuBhlUbapoMa6fF9A-6pPWI3aP4u4kgYLMZ8042uwpIE8&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1cspCDjEJpBq3J97VGzCiV3anTKfttUu3tQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKxpWjfUGHgdIObuIEASHY3py3LGvhMd9X6oMVuKMlODx6LXQq7NZFEyDEAC-Pgyd4m9M&usqp=CAU',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 90,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          items: imgList
              .map((item) => SizedBox(
                    width: 320,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 320,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        alphaheight20,
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: imgList.length,
          effect: ExpandingDotsEffect(
            dotHeight: 4,
            dotWidth: 8,
            activeDotColor: colorScheme.primary,
            dotColor: Theme.of(context).primaryColor,
            expansionFactor: 3,
            spacing: 10,
          ),
        ),
      ],
    );
  }
}