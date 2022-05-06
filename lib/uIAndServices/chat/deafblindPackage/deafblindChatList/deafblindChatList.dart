import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateMessages.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatList/deafblindUserTitle.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/typeTextSearchScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/splashScreen.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class deafblindChatList extends StatefulWidget {
  static const String routName = 'deafblindChatList';

  @override
  State<deafblindChatList> createState() => _deafblindChatListState();
}

class _deafblindChatListState extends State<deafblindChatList> {
  final vibrationInAction _vibrationInAction = vibrationInAction();
  List<String> unreadNames = [];
  List<String> names = [];
  final vibrateMessages _messages = vibrateMessages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 87, 207),
        centerTitle: true,
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (buildContext) => [
                    PopupMenuItem(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, splashScreen.routname, (route) => false);
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ])
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SimpleGestureDetector(
          onHorizontalSwipe: (SwipeDirection direction) {
            if (direction == SwipeDirection.right) {
              Navigator.pushNamed(context, typeTextSearchScreen.routName);
              _vibrationInAction.vibrateInAction();
            }
            if (direction == SwipeDirection.left) {
              print(names);
              _messages.vibrateMessagesChat(names);
              // names=[];
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 1, 87, 207),
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Text(
                      localUserData.getUserName().substring(0, 1),
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      localUserData.getUserName(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: Colors.grey,
                      width: 2,
                      height: 2,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<userDataUsersList>>(
                  stream: userDataUsersList
                      .withConverter(localUserData.getUId())
                      .orderBy('dateTime', descending: true)
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
                    // setState(() {
                    // });
                    var user =
                        snapshot.data!.docs.map((doc) => doc.data()).toList();
                    if (user.isNotEmpty) {
                      unreadNames = [];
                      for (int i = 0; i < user.length; i++) {
                        if (user[i].flag == 'true') {
                          unreadNames.add(user[i].userName);
                          names = unreadNames;
                        }
                      }
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: user.length,
                        itemBuilder: (buildContext, index) {
                          var _user = userData(
                              userName: user.elementAt(index).userName,
                              phoneNumber: user.elementAt(index).phoneNumber,
                              uID: user.elementAt(index).uID,
                              chooseMood: user.elementAt(index).chooseMood,
                              picturePath: '');
                          return deafblindUserTitle(
                            user: _user,
                            userFlag: user.elementAt(index),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
