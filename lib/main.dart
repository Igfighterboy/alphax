import 'package:flutter/material.dart';
import 'package:myapp/core/themes/alphathemenotifier.dart';
import 'package:myapp/core/themes/alphathemes.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeNotifier.themeMode == ThemeModeType.system
                ? ThemeMode.system
                : themeNotifier.themeMode == ThemeModeType.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
