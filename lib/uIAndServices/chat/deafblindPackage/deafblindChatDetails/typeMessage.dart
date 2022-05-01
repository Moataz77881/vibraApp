import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:morse/morse.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class typeMessage extends StatefulWidget {
  static const String routName = 'typeMessage';

  @override
  State<typeMessage> createState() => _typeMessageState();
}

class _typeMessageState extends State<typeMessage> {
  String contentMessage = '';
  late userData userDetails;
  String textMessage = '';

  vibrationInAction _vibrateInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    userDetails = ModalRoute.of(context)?.settings.arguments as userData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SimpleGestureDetector(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 1, 87, 207)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(15, 15))))),
                      onPressed: () {
                        //todo .
                        contentMessage += '.';
                        _vibrateInAction.vibrationTheText('.');
                        print(contentMessage);
                      },
                      child: Text(
                        'Type your message',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onLongPress: () {
                    // todo -
                    contentMessage += '-';
                    _vibrateInAction.vibrationTheText('-');
                    print(contentMessage);
                  },
                  onDoubleTap: () {
                    // todo send message
                    // Navigator.pop(context);
                    Morse morse = Morse(contentMessage);
                    textMessage = morse.decode();
                    sendMessage();
                    _vibrateInAction.vibrateInAction();
                    Navigator.pop(context);
                  },
                ),
                onVerticalSwipe: (SwipeDirection direction) {
                  setState(() {
                    if (direction == SwipeDirection.down) {
                      contentMessage += ' / ';
                      _vibrateInAction.vibrateInAction();
                      print(contentMessage);
                    } else if (direction == SwipeDirection.up) {
                      contentMessage += ' ';
                      _vibrateInAction.vibrateInAction();
                      print(contentMessage);
                    }
                  });
                },
                onHorizontalSwipe: (SwipeDirection direction) {
                  setState(() {
                    if (direction == SwipeDirection.right) {
                      if (contentMessage.isNotEmpty) {
                        contentMessage = contentMessage.substring(
                            0, contentMessage.length - 1);
                        _vibrateInAction.vibrateInAction();
                        print(contentMessage);
                      }
                    } else if (direction == SwipeDirection.left) {
                      Navigator.pop(context);
                      _vibrateInAction.vibrateInAction();
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() async {
    messageData messageDataObject = messageData(
        id: '',
        content: textMessage,
        dateTime: DateTime.now(),
        senderId: localUserData.getUId());

    userDataUsersList _userDataUsersList = userDataUsersList(
        userName: userDetails.userName,
        phoneNumber: userDetails.phoneNumber,
        chooseMood: userDetails.chooseMood,
        uID: userDetails.uID,
        dateTime: messageDataObject.dateTime,
        senderId: messageDataObject.senderId,
        flag: 'false');

    userDataUsersList _userDataUsersListProvider = userDataUsersList(
        userName: localUserData.getUserName(),
        phoneNumber: localUserData.getPhoneNumber(),
        chooseMood: localUserData.getChooseMood(),
        uID: localUserData.getUId(),
        dateTime: messageDataObject.dateTime,
        senderId: messageDataObject.senderId,
        flag: 'true');

    var result1 = await setOrRetrieveData.addMessage(messageDataObject,
        userDetails.uID, messageDataObject.senderId); // id bta3 mohab
    var result2 = await setOrRetrieveData.addMessage(
        messageDataObject, messageDataObject.senderId, userDetails.uID);
    setOrRetrieveData.setChatList(
        messageDataObject.senderId, userDetails.uID, _userDataUsersList);
    setOrRetrieveData.setChatList(userDetails.uID, messageDataObject.senderId,
        _userDataUsersListProvider);
  }
}
