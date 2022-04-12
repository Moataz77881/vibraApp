import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
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

  List<String> listOfContent = [];

  vibrationInAction _vibrateInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    userDetails = ModalRoute.of(context)?.settings.arguments as userData;
    return Scaffold(
      backgroundColor: Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: InkWell(
        onDoubleTap: () {
          print(listOfContent);
          _vibrateInAction.vibrateInAction();
        },
        child: SimpleGestureDetector(
          onHorizontalSwipe: (SwipeDirection direction) {
            if (direction == SwipeDirection.right) {
              Navigator.pushNamed(context, typeMessage.routName,
                  arguments: userDetails);
              _vibrateInAction.vibrateInAction();
            } else if (direction == SwipeDirection.left) {
              Navigator.pop(context);
              _vibrateInAction.vibrateInAction();
            }
          },
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 1, 87, 207),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                          child: Text(
                        userDetails.userName.substring(0, 1),
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(userDetails.userName,
                          style: TextStyle(
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
                    padding: EdgeInsets.all(12),
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
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data!.docs
                            .map((doc) => doc.data())
                            .toList();

                        // if(data != null && data.isNotEmpty){
                        //   for(int i=data.length-2 ; i>=0; i--){
                        //     if(data[i].senderId == userDetails.uID){
                        //       listOfContent[i] = data[i].content;
                        //     }
                        //     if(data[i-1].senderId == localUserData.getUId()){
                        //       break;
                        //     }
                        //   }
                        // }
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext, index) {
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
