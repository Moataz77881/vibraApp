import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/caregiverChatListDetails/caregiverChatList.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/chatDetailsScreen.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/searchCaregiverPackge/searchScreen.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/typeMessage.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatList/deafblindChatList.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/searchScreenList.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/typeTextSearchScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/loginScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/optionScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/otpScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/splashScreen.dart';

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginScreen.routeName: (buildContext) => loginScreen(),
        optionScreen.routeName: (buildContext) => optionScreen(),
        splashScreen.routname: (buildContext) => splashScreen(),
        otpScreen.routName: (buildContext) => otpScreen(),
        caregiverChatList.routName: (buildContext) => caregiverChatList(),
        deafblindChatList.routName: (buildContext) => deafblindChatList(),
        searchScreen.routName: (buildContext) => searchScreen(),
        chatDetailsScreen.routName: (buildContext) => chatDetailsScreen(),
        deafblindChatDetailsScreen.routName: (buildContext) =>
            deafblindChatDetailsScreen(),
        typeMessage.routName: (buildContext) => typeMessage(),
        typeTextSearchScreen.routName: (buildContext) => typeTextSearchScreen(),
        searchScreenList.routName: (buildContext) => searchScreenList()
      },
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? localUserData.getChooseMood() == 'I am Caregiver'
              ? caregiverChatList.routName
              : deafblindChatList.routName
          : splashScreen.routname,
    );
  }
}
