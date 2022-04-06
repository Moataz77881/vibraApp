import 'package:flutter/material.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/caregiverListDetails/caregiverChatList.dart';
import 'package:graduation_project/uIAndServices/caregiverListDetails/chatDetails/chatDetailsScreen.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatDetails/typeMessage.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatList/deafblindChatList.dart';
import 'package:graduation_project/uIAndServices/loginScreen.dart';
import 'package:graduation_project/uIAndServices/optionScreen.dart';
import 'package:graduation_project/uIAndServices/otpScreen.dart';
import 'package:graduation_project/uIAndServices/searchPackge/searchScreen.dart';
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
        searchScreen.routName: (BuildContext) => searchScreen(),
        chatDetailsScreen.routName: (BuildContext) => chatDetailsScreen(),
        deafblindChatDetailsScreen.routName: (BuildContext) =>
            deafblindChatDetailsScreen(),
        typeMessage.routName: (BuildContext) => typeMessage()
      },

      initialRoute: deafblindChatList.routName,
      // initialRoute: provider.isVerifyed()
      //     ? provider.user?.chooseMood == 'I am Caregiver'
      //         ? caregiverForeChatList.routName
      //         : deafblindChatList.routName
      //     : splashScreen.routname,
    );
  }
}
