import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';

class deafblindTitle extends StatelessWidget {
  userData user;

  deafblindTitle({required this.user});

  final vibrationInAction _vibrationInAction = vibrationInAction();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 600,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(107, 212, 212, 212),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                user.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ],
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
