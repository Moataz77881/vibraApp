import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateInMorse.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';

class deafblindUserTitle extends StatelessWidget {
  static const String routName = 'deafblindUserTitle';
  userData? user;

  deafblindUserTitle({required this.user});

  vibrateInMorse _vibrateInMorse = new vibrateInMorse();
  vibrationInAction _vibrateInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _vibrateInMorse.vibrateInMorseText(user!.userName);
      },
      onDoubleTap: () {
        Navigator.pushNamed(context, deafblindChatDetailsScreen.routName,
            arguments: user);
        _vibrateInAction.vibrateInAction();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 87, 207),
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                  child: Text(
                user!.userName.substring(0, 1),
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
                child: Text(user != null
                    ? user!.userName
                    : deafblindUserTitle.routName))
          ],
        ),
      ),
    );
  }
}

