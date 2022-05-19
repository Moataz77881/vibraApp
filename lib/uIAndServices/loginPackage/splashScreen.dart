import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/loginPackage/loginScreen.dart';

class splashScreen extends StatelessWidget {
  static const String routname = 'splashScreen';
  int time_duration = 3000;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/vibraWhite.png',
      // splash image
      nextScreen: loginScreen(),
      //navigation
      backgroundColor: Colors.white,
      splashIconSize: 200,
      //size of splash image
      duration: 2000,
      // time
      animationDuration: Duration(milliseconds: this.time_duration),
    );
  }
}
