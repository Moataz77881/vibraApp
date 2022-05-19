import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateMessages.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindMessageWidget.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/typeMessage.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class deafblindChatDetailsScreen extends StatefulWidget {
  static const String routName = 'deafblind Chat details screen';

  @override
  State<deafblindChatDetailsScreen> createState() =>
      _deafblindChatDetailsScreenState();
}

class _deafblindChatDetailsScreenState
    extends State<deafblindChatDetailsScreen> {
  late userData userDetails;
  int size = 0;
  List<String> listOfContent = [];
  List<String> listOfContentCopy = [];
  List<String> listOfNewMessage = [];
  List<String> contentMessages = [];
  final vibrationInAction _vibrateInAction = vibrationInAction();
  final vibrateMessages _vibrateMessages = vibrateMessages();
  late DateTime lastMessageDateTime;

  @override
  Widget build(BuildContext context) {
    userDetails = ModalRoute.of(context)?.settings.arguments as userData;
    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 87, 207),
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: InkWell(
        onDoubleTap: () {
          if (listOfContent.isNotEmpty) {
            listOfContentCopy = [];
            for (int i = listOfContent.length - 1; i >= 0; i--) {
              listOfContentCopy.add(listOfContent[i]);
            }
          }
          _vibrateMessages.vibrateMessagesChat(listOfContentCopy);
          print(listOfContentCopy);
          listOfContent = [];
        },
        onTap: () {
          if (listOfContent.isNotEmpty) {
            if (listOfContentCopy.isNotEmpty) {
              if (listOfContent.length != listOfContentCopy.length) {
                size = listOfContent.length - listOfContentCopy.length;
                for (int i = size - 1; i >= 0; i--) {
                  listOfContentCopy.add(listOfContent[i]);
                  listOfNewMessage.add(listOfContent[i]);
                }
                listOfContent = [];
              }
            }
          }
          _vibrateMessages.vibrateMessagesChat(listOfNewMessage);
          print(listOfNewMessage);
        },
        child: SimpleGestureDetector(
          onHorizontalSwipe: (SwipeDirection direction) {
            if (direction == SwipeDirection.right) {
              Navigator.pushNamed(context, typeMessage.routName,
                  arguments: userDetails);
              _vibrateInAction.vibrateInAction();
            } else if (direction == SwipeDirection.left) {
              Navigator.pop(context);
              //todo flag false
              var user = userDataUsersList(
                  uID: userDetails.uID,
                  userName: userDetails.userName,
                  phoneNumber: userDetails.phoneNumber,
                  lastMessage: '',
                  dateTime: lastMessageDateTime,
                  chooseMood: userDetails.chooseMood,
                  senderId: localUserData.getUId(),
                  picturePath: userDetails.picturePath,
                  flag: 'false');
              setOrRetrieveData.updateChatList(
                  localUserData.getUId(), userDetails.uID, user);
              _vibrateInAction.vibrateInAction();
            }
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 15, 111, 255),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                          child: Text(
                        userDetails.userName.substring(0, 1),
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(userDetails.userName,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.grey,
                      width: 2,
                      height: 1,
                    )),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: StreamBuilder<QuerySnapshot<messageData>>(
                      stream: messageData
                          .withConverter(
                              localUserData.getUId(), userDetails.uID)
                          .orderBy('dateTime', descending: false)
                          .snapshots(),
                      builder: (builder, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data!.docs
                            .map((doc) => doc.data())
                            .toList();
                        if (data.isNotEmpty) {
                          listOfNewMessage = [];
                          for (int i = data.length - 1; i >= 0; i--) {
                            if (i == data.length - 1) {
                              lastMessageDateTime = data[i].dateTime;
                            }
                            if (data[i].senderId != localUserData.getUId()) {
                              contentMessages.add(data[i].content);
                              listOfContent = contentMessages;
                              if (i == 0) {
                                //todo
                                contentMessages = [];
                              }
                              if (i > 1) {
                                if (data[i - 1].senderId ==
                                    localUserData.getUId()) {
                                  contentMessages = [];
                                  break;
                                }
                              }
                            } else {
                              break;
                            }
                          }
                        }
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (buildContext, index) {
                              return deafblindMessageWidget(
                                  messageDataObject: data[index]);
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
