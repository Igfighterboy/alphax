import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/pages/profilescreen/profilewidgets/profilebadges.dart';
import 'package:myapp/pages/profilescreen/profilewidgets/profileuserwidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ProfileUserProfile(colorScheme: colorScheme),
            alphaheight20,
            ProfileBadges()
          ],
        ),
      ),
    ));
  }
}
