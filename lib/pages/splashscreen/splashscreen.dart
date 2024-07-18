import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/pages/onboardingscreen/onboardingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Center(
            child: SplashMainArea(),
          ))
        ],
      ),
    );
  }
}

class SplashMainArea extends StatefulWidget {
  const SplashMainArea({
    super.key,
  });

  @override
  State<SplashMainArea> createState() => _SplashMainAreaState();
}

class _SplashMainAreaState extends State<SplashMainArea>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1.3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),
        alphaheight20,
        Container(
          width: 140,
          height: 6.5,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(80),
          ),
          child: LinearProgressIndicator(
            value: controller.value,
            backgroundColor: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            valueColor: AlwaysStoppedAnimation<Color>(
                colorScheme.primary), // Make the background transparent
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Column(
          children: [
            Text(
              'From',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'LexendDeca'),
            ),
            Text(
              'ELiTE DEVS',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'LexendDeca'),
            )
          ],
        ),
        const Spacer()
      ],
    );
  }
}
