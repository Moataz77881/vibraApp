import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatList/deafblindUserTitle.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/typeTextSearchScreen.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class deafblindChatList extends StatelessWidget {
  static const String routName = 'deafblindChatList';
  vibrationInAction _vibrationInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        centerTitle: true,
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SimpleGestureDetector(
          onHorizontalSwipe: (SwipeDirection direction) {
            if (direction == SwipeDirection.right) {
              Navigator.pushNamed(context, typeTextSearchScreen.routName);
              _vibrationInAction.vibrateInAction();
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 1, 87, 207),
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Text(
                      localUserData.getUserName().substring(0, 1),
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      localUserData.getUserName(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      color: Colors.grey,
                      width: 2,
                      height: 2,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var user =
                          snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: user.length,
                          itemBuilder: (BuildContext, index) {
                            var _user = userData(
                                userName: user.elementAt(index).userName,
                                phoneNumber: user.elementAt(index).phoneNumber,
                                uID: user.elementAt(index).uID,
                                chooseMood: user.elementAt(index).chooseMood);
                            return deafblindUserTitle(user: _user);
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
