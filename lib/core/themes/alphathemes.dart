import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';

class AlphaTheme {
  static final darkTheme = ThemeData(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: darkbackgroundcolor,
    primaryColor: darktextcolor,
    colorScheme: ColorScheme.light().copyWith(
      primary: darkactivecolor,
      secondary: darkmaincontainercolor,
      surface: darksubcontainercolor,
    ),
    // APPBAR
    appBarTheme: AppBarTheme(
          backgroundColor: darkbarcolor, // Set the AppBar background color here
          elevation: 0, // Set the AppBar elevation here
    ),

    // BOTTOMBAR
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkbackgroundcolor,
        indicatorColor: bothtabbackgroundcolor,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            color: darktextcolor,
            fontFamily: 'LexendDeca',
          ),
        ),
    ),
  );
  static final lightTheme = ThemeData(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: lightbackgroundcolor,
    primaryColor: lighttextcolor,
    colorScheme: ColorScheme.light().copyWith(
      primary: lightactivecolor,
      secondary: lightmaincontainercolor,
      surface: lightsubcontainercolor,
    ),
    // APPBAR
    appBarTheme: AppBarTheme(
          backgroundColor: lightbarcolor, 
          elevation: 0, 
    ),

    // BOTTOMBAR
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightbackgroundcolor,
        indicatorColor: bothtabbackgroundcolor,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            color: lighttextcolor,
            fontFamily: 'LexendDeca',
          ),
        ),
    ),
  );
}

    // final colorScheme = Theme.of(context).colorScheme;