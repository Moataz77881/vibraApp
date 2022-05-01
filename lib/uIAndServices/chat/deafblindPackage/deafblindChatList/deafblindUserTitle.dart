import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateInMorse.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindChatDetailsScreen.dart';

class deafblindUserTitle extends StatefulWidget {
  static const String routName = 'deafblindUserTitle';
  userData? user;
  userDataUsersList userFlag;

  deafblindUserTitle({required this.user, required this.userFlag});

  @override
  State<deafblindUserTitle> createState() => _deafblindUserTitleState();
}

class _deafblindUserTitleState extends State<deafblindUserTitle> {
  final vibrateInMorse _vibrateInMorse = vibrateInMorse();

  final vibrationInAction _vibrateInAction = vibrationInAction();

  @override
  Widget build(BuildContext context) {
    var _user;
    setState(() {
      _user = userDataUsersList(
          uID: widget.userFlag.uID,
          userName: widget.userFlag.userName,
          phoneNumber: widget.userFlag.phoneNumber,
          dateTime: widget.userFlag.dateTime,
          chooseMood: widget.userFlag.chooseMood,
          senderId: widget.userFlag.senderId,
          flag: 'false');
    });
    return InkWell(
      onTap: () {
        _vibrateInMorse.vibrateInMorseText(widget.user!.userName);
      },
      onDoubleTap: () {
        Navigator.pushNamed(context, deafblindChatDetailsScreen.routName,
            arguments: widget.user);
        setOrRetrieveData.updateChatList(
            localUserData.getUId(), widget.userFlag.uID, _user);
        _vibrateInAction.vibrateInAction();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 1, 87, 207),
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                  child: Text(
                widget.user!.userName.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              )),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(widget.user != null
                ? widget.user!.userName
                : deafblindUserTitle.routName)
          ],
        ),
      ),
    );
  }
}

