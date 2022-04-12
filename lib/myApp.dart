import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/caregiverChatListDetails/caregiverChatList.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/chatDetailsScreen.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/searchCaregiverPackge/searchScreen.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/typeMessage.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatList/deafblindChatList.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/searchScreenList.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/typeTextSearchScreen.dart';
import 'package:graduation_project/uIAndServices/loginScreen.dart';
import 'package:graduation_project/uIAndServices/optionScreen.dart';
import 'package:graduation_project/uIAndServices/otpScreen.dart';
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
        caregiverChatList.routName: (BuildContext) => caregiverChatList(),
        deafblindChatList.routName: (BuildContext) => deafblindChatList(),
        searchScreen.routName: (BuildContext) => searchScreen(),
        chatDetailsScreen.routName: (BuildContext) => chatDetailsScreen(),
        deafblindChatDetailsScreen.routName: (BuildContext) =>
            deafblindChatDetailsScreen(),
        typeMessage.routName: (BuildContext) => typeMessage(),
        typeTextSearchScreen.routName: (BuildContext) => typeTextSearchScreen(),
        searchScreenList.routName: (BuildContext) => searchScreenList()
      },
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? localUserData.getChooseMood() == 'I am Caregiver'
              ? caregiverChatList.routName
              : deafblindChatList.routName
          : splashScreen.routname,
    );
  }
}
