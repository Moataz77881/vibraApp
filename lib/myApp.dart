import 'package:flutter/material.dart';
import 'package:graduation_project/splashScreen.dart';

import 'loginScreen.dart';
import 'optionScreen.dart';

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginScreen.routeName: (BuildContext) => loginScreen(),
        optionScreen.routeName: (BuildContext) => optionScreen(),
        splashScreen.routname: (BuildContext) => splashScreen()
      },
      initialRoute: splashScreen.routname,
      // initialRoute: loginScreen.routeName,
    );
  }
}
