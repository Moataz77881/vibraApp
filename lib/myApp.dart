import 'package:flutter/material.dart';
import 'package:graduation_project/UI/splashScreen.dart';

import 'UI/loginScreen.dart';
import 'UI/optionScreen.dart';

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginScreen.routeName: (BuildContext) => loginScreen(),
        optionScreen.routeName: (BuildContext) => optionScreen(),
        splashScreen.routname: (BuildContext) => splashScreen(),
      },
      initialRoute: splashScreen.routname,
      // initialRoute: loginScreen.routeName,
    );
  }
}
