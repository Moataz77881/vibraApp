import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/VibrateMorseText/vibrateInMorse.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';

class deafblindUserTitle extends StatefulWidget {
  userData? user;

  deafblindUserTitle({required this.user});

  @override
  State<deafblindUserTitle> createState() => _deafblindUserTitleState();
}

class _deafblindUserTitleState extends State<deafblindUserTitle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          vibrateInMorse _vibrateInMorse = new vibrateInMorse();
          _vibrateInMorse.vibrateInMorseText(widget.user!.userName);
        });
      },
      onDoubleTap: () {
        Navigator.pushNamed(context, deafblindChatDetailsScreen.routName,
            arguments: widget.user);
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
                widget.user!.userName.substring(0, 1),
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              width: 8,
            ),
            Container(child: Text(widget.user!.userName))
          ],
        ),
      ),
    );
  }
}

