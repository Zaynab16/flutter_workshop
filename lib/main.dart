import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/screens/diagnose.dart';
import 'package:flutter_workshop/screens/home.dart';
import 'package:flutter_workshop/screens/homescreen.dart';
import 'package:flutter_workshop/screens/newchatbot.dart';
import 'package:flutter_workshop/screens/payment.dart';
import 'package:flutter_workshop/screens/settings.dart';
import 'package:flutter_workshop/screens/signin_screen.dart';
import 'package:flutter_workshop/screens/splash.dart';
import 'package:flutter_workshop/screens/theme_notifier.dart';
import 'package:provider/provider.dart';


void main() async {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //???
      theme: Provider.of<ThemeNotifier>(context).getTheme(),
      title: 'My App',
      home:AnimatedSplashScreen(
        splash: Splash(),
    nextScreen: Homescreen(),
    splashTransition: SplashTransition.fadeTransition,
    backgroundColor: Color(0xFF1F3D1D),
    splashIconSize: 300,
    ),
      routes: {
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}


