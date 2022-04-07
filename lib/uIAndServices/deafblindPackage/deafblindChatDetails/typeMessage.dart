import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:morse/morse.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class typeMessage extends StatefulWidget {
  static const String routName = 'typeMessage';

  @override
  State<typeMessage> createState() => _typeMessageState();
}

class _typeMessageState extends State<typeMessage> {
  String contentMessage = '';
  late userData userDetails;
  late authProvider provider;
  String textMessage = '';

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<authProvider>(context);
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
                    print(contentMessage);
                  },
                  onDoubleTap: () {
                    // todo send message
                    // Navigator.pop(context);
                    Morse morse = new Morse(contentMessage);
                    textMessage = morse.decode();
                    sendMessage();
                    Navigator.pop(context);
                  },
                ),
                onVerticalSwipe: (SwipeDirection direction) {
                  setState(() {
                    if (direction == SwipeDirection.down) {
                      contentMessage += ' / ';
                      print(contentMessage);
                    } else if (direction == SwipeDirection.up) {
                      contentMessage += ' ';
                      print(contentMessage);
                    }
                  });
                },
                onHorizontalSwipe: (SwipeDirection direction) {
                  setState(() {
                    if (direction == SwipeDirection.right) {
                      if (contentMessage != null && contentMessage.length > 0) {
                        contentMessage = contentMessage.substring(
                            0, contentMessage.length - 1);
                        print(contentMessage);
                      }
                    } else if (direction == SwipeDirection.left) {
                      Navigator.pop(context);
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
        senderId: provider.user!.uID);

    userDataUsersList _userDataUsersList = userDataUsersList(
        userName: userDetails.userName,
        phoneNumber: userDetails.phoneNumber,
        chooseMood: userDetails.chooseMood,
        uID: userDetails.uID,
        dateTime: messageDataObject.dateTime);

    userDataUsersList _userDataUsersListProvider = userDataUsersList(
        userName: provider.user!.userName,
        phoneNumber: provider.user!.phoneNumber,
        chooseMood: provider.user!.chooseMood,
        uID: provider.user!.uID,
        dateTime: messageDataObject.dateTime);

    var result1 = await setOrRetrieveData.addMessage(messageDataObject,
        userDetails.uID, messageDataObject.senderId); // id bta3 mohab
    var result2 = await setOrRetrieveData.addMessage(
        messageDataObject, messageDataObject.senderId, userDetails.uID);
    setOrRetrieveData.getChatList(
        messageDataObject.senderId, userDetails.uID, _userDataUsersList);
    setOrRetrieveData.getChatList(userDetails.uID, messageDataObject.senderId,
        _userDataUsersListProvider);
  }
}
