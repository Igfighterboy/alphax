import 'dart:convert'; // Import jsonDecode
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserProfile extends StatefulWidget {
  const ProfileUserProfile({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  _ProfileUserProfileState createState() => _ProfileUserProfileState();
}

class _ProfileUserProfileState extends State<ProfileUserProfile> {
  String _userName = 'User';
  String _userEmail = 'user@example.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      final user = jsonDecode(userJson) as Map<String, dynamic>;
      setState(() {
        _userName = user['username'] ?? 'User';
        _userEmail = user['email'] ?? 'user@example.com';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
              fit: BoxFit.cover,
              width: 105,
              height: 105,
            ),
          ),
        ),
        alphaheight10,
        Text(
          _userName,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontFamily: 'LexendDeca',
              color: Theme.of(context).primaryColor),
        ),
        Text(
          _userEmail,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'LexendDeca',
              color: Theme.of(context).primaryColor),
        ),
        alphaheight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                color: widget.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Broken.user_edit, color: iconscolor),
                    alphawidth10,
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: iconscolor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca'),
                    )
                  ],
                ),
              ),
            ),
            alphawidth10,
            Container(
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                color: widget.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Broken.setting_2, color: iconscolor),
                    alphawidth10,
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: iconscolor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
