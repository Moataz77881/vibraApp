import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';

class deafblindTitle extends StatelessWidget {
  userData user;

  deafblindTitle({required this.user});

  vibrationInAction _vibrationInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          width: 20,
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromARGB(107, 212, 212, 212),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            user.userName,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
      ),
      onDoubleTap: () {
        // go to the chat screen
        Navigator.pushNamed(context, deafblindChatDetailsScreen.routName,
            arguments: user);
      },
      onTap: () {
        _vibrationInAction.vibrateInMorseText(user.userName);
      },
    );
  }
}
