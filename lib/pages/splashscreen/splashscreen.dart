import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:myapp/controller/recentcontroller/played_song_services.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/pages/mainscreen/mainscreen.dart';
import 'package:myapp/pages/onboardingscreen/onboardingscreen.dart';
import 'package:myapp/pages/signscreen/signinscreen/signinscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final playedSongsService = PlayedSongsService();
    final playedSongs = await playedSongsService.loadPlayedSongs();
    final playerState = Provider.of<PlayerState>(context, listen: false);
    playerState.updatePlayedSongs(playedSongs);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('userToken');
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null) {
        Get.offAll(() => MainScreen(),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1));
      } else {
        Get.offAll(() => const SignInScreen(),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1));
      }
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
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
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
