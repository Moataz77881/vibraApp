import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/UI/loginScreen.dart';

class splashScreen extends StatelessWidget {
  static const String routname = 'splashScreen';
  int time_duration = 3000;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/vibra.png',
      // splash image
      nextScreen: loginScreen(),
      //navigation
      backgroundColor: Color.fromARGB(255, 1, 87, 207),
      splashIconSize: 200,
      //size of splash image
      duration: 2000,
      // time
      animationDuration: Duration(milliseconds: this.time_duration),
    );
    // child: SplashScreen(
    //   seconds: 6,
    //   image: Image.asset('assets/images/vibra.png'),
    //   photoSize: 100.0,
    //   backgroundColor: Color.fromARGB(255, 1, 87, 207),
    //   navigateAfterSeconds: loginScreen(),
    //   useLoader: false,
    // onClick: ()=>print("Flutter Egypt"),
  }
}
