import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/core/themes/alphathemes.dart';
import 'package:myapp/pages/mainscreen/mainscreen.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALPhA MUSIX',
      themeMode: ThemeMode.system,
      theme: AlphaTheme.lightTheme,
      darkTheme: AlphaTheme.darkTheme,
      // home: MainScreen(),
      home: SplashScreen(),
    );
  }
}
