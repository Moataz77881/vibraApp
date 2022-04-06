import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';
import 'package:morse/morse.dart';
import 'package:vibration/vibration.dart';

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
          // vibrateInMorse(widget.user!.userName);
          vibrationTheText();
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

void vibrateInMorse(String userName) {
  final Morse morse = new Morse(userName);
  var userNameMorse = morse.encode();
  int i = 0;
  if (i <= userNameMorse.length) {
    // vibrationTheText(userNameMorse[i] , i);
    i++;
  }
}

Future<void> vibrationTheText() async {
  List<int> pattern = [1000, 500, 100];
  for (int i = 0; i < pattern.length; i++) {
    await Vibration.vibrate(duration: pattern[i]);
  }
  // if(userNameMorse[i] == '.'){
  //   await Vibration.vibrate(duration: 500 );
  // }else if(userNameMorse[i] == '-'){
  //   await Vibration.vibrate(duration: 1000);
  // }
}
