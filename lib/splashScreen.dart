import 'package:flutter/material.dart';
import 'package:graduation_project/loginScreen.dart';
import 'package:splashscreen/splashscreen.dart';

class splashScreen extends StatelessWidget {
  static const String routname = 'splashScreen';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
        seconds: 6,
        image: Image.asset('assets/images/vibra.png'),
        photoSize: 100.0,
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        navigateAfterSeconds: loginScreen(),
        useLoader: false,
        // onClick: ()=>print("Flutter Egypt"),
      ),
    );
  }
}
