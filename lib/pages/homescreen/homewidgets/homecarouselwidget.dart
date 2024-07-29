import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';

class HomeCarouselWidget extends StatefulWidget {
  const HomeCarouselWidget({super.key});

  @override
  State<HomeCarouselWidget> createState() => _HomeCarouselWidgetState();
}

class _HomeCarouselWidgetState extends State<HomeCarouselWidget> {
  List<String> imgList = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    final response =
        await http.get(Uri.parse('http://172.232.124.96:5056/images'));
    if (response.statusCode == 200) {
      setState(() {
        imgList = List<String>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imgList.isNotEmpty)
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
              },
            ),
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
          )
        else
          _buildShimmerPlaceholder(),
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

  Widget _buildShimmerPlaceholder() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 90,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
      ),
      items: List.generate(5, (index) => _buildShimmerItem()).toList(),
    );
  }

  Widget _buildShimmerItem() {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 320,
      child: Shimmer.fromColors(
        baseColor: colorScheme.secondary,
        highlightColor: colorScheme.surface,
        child: Container(
          width: 320,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
