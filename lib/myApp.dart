import 'package:flutter/material.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/caregiverChatList.dart';
import 'package:graduation_project/uIAndServices/deafblindChatList.dart';
import 'package:graduation_project/uIAndServices/loginScreen.dart';
import 'package:graduation_project/uIAndServices/optionScreen.dart';
import 'package:graduation_project/uIAndServices/otpScreen.dart';
import 'package:graduation_project/uIAndServices/searchScreen.dart';
import 'package:graduation_project/uIAndServices/splashScreen.dart';
import 'package:provider/provider.dart';

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<authProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginScreen.routeName: (BuildContext) => loginScreen(),
        optionScreen.routeName: (BuildContext) => optionScreen(),
        splashScreen.routname: (BuildContext) => splashScreen(),
        otpScreen.routName: (BuildContext) => otpScreen(),
        caregiverForeChatList.routName: (BuildContext) =>
            caregiverForeChatList(),
        deafblindChatList.routName: (BuildContext) => deafblindChatList(),
        searchScreen.routName: (BuildContext) => searchScreen()
      },
      initialRoute: provider.isVerifyed()
          ? provider.user?.chooseMood == 'I am Caregiver'
              ? deafblindChatList.routName
              : caregiverForeChatList.routName
          : splashScreen.routname,
      // initialRoute: caregiverForeChatList.routName,
    );
  }
}
