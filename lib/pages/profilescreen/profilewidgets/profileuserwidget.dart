import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class ProfileUserProfile extends StatelessWidget {
  const ProfileUserProfile({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

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
          'UserName',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontFamily: 'LexendDeca',
              color: Theme.of(context).primaryColor),
        ),
        Text(
          'username@gmail.com',
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
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Broken.user_edit,color: iconscolor,),
                    alphawidth10,
                    Text('Edit Profile',style: TextStyle(
                      color: iconscolor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'LexendDeca'
                    ),)
                  ],
                ),
              ),
            ),
            alphawidth10,
            Container(
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Broken.setting_2,color: iconscolor,),
                    alphawidth10,
                    Text('Settings',style: TextStyle(
                      color: iconscolor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'LexendDeca'
                    ),),
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