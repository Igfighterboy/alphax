import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/accountscreation/accountcreation.dart';
import 'package:myapp/pages/mainscreen/mainscreen.dart';
import 'package:myapp/pages/onboardingscreen/onboardingwidget/onboardingitems.dart';
import 'package:myapp/pages/signscreen/signinscreen/signinscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final onboardingitems = OnboardingItems();
  final PageController _controller = PageController();
  int currentPage = 0;

  void _skip() {
    _controller.jumpToPage(4);
  }

  void _nextPage() {
    if (currentPage < 4) {
      _controller.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.to(() => AccountCreation(),
          transition: Transition.cupertino,
          duration: Duration(
            seconds: 1,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(child: child, opacity: animation);
                },
                child: currentPage < 4
                    ? Container(
                        key: ValueKey<int>(
                            currentPage), // Key for AnimatedSwitcher
                        width: 90,
                        height: 35,
                        decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: _skip,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Skip',
                                style: TextStyle(
                                  color: buttontext,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'LexendDeca',
                                ),
                              ),
                              alphawidth10,
                              Icon(Broken.arrow_right_1, color: buttontext)
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        key: ValueKey<int>(currentPage), width: 0, height: 0),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: onboardingitems.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            onboardingitems.items[index].onTitle,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.primary,
                                fontFamily: 'LexendDeca'),
                            textAlign:
                                onboardingitems.items[index].onTitleAlign,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            onboardingitems.items[index].onSubtitle,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'LexendDeca'),
                            textAlign:
                                onboardingitems.items[index].onSubTitleAlign,
                          ),
                        ),
                        alphaheight10,
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: SvgPicture.asset(
                            onboardingitems.items[index].onImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          onboardingitems.items[index].onDescriptions,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'LexendDeca'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 15),
          child: Row(
            children: [
              SmoothPageIndicator(
                controller: _controller,
                count: 5,
                effect: ExpandingDotsEffect(
                  dotHeight: 4,
                  dotWidth: 8,
                  activeDotColor: colorScheme.primary,
                  dotColor: Theme.of(context).primaryColor,
                  expansionFactor: 3,
                  spacing: 10,
                ),
              ),
              const Spacer(),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 40,
                width: 145,
                decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(child: child, opacity: animation);
                  },
                  child: TextButton(
                    key: ValueKey<int>(currentPage),
                    onPressed: _nextPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentPage < 4 ? 'Next' : 'Get Started',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: buttontext,
                            fontFamily: 'LexendDeca',
                          ),
                        ),
                        alphawidth10,
                        Icon(
                          Broken.arrow_right_3,
                          color: buttontext,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
