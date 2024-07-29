import 'package:flutter/material.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:myapp/core/themes/alphathemenotifier.dart';
import 'package:myapp/core/themes/alphathemes.dart';
import 'package:myapp/pages/splashscreen/splashscreen.dart';
import 'controller/playercontroller/playerstate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerState()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

void initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
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
    );
  }
}
