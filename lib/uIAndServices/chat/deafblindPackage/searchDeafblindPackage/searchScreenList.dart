import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/deafblindTitle.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class searchScreenList extends StatefulWidget {
  static const String routName = 'searchScreenList';

  @override
  State<searchScreenList> createState() => _searchScreenListState();
}

class _searchScreenListState extends State<searchScreenList> {
  vibrationInAction _vibrationInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    var contentSearch = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        backgroundColor: Color.fromARGB(206, 250, 250, 251),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 1, 87, 207),
          title: Image.asset(
            "assets/images/vibra.png",
            width: 120,
            height: 120,
          ),
          centerTitle: true,
        ),
        body: SimpleGestureDetector(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Container(
                    child: Expanded(
                  child: StreamBuilder<QuerySnapshot<userData>>(
                      stream: userData
                          .withConverter()
                          .where('userName', isEqualTo: contentSearch)
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
                            snapshot.data?.docs.map((e) => e.data()).toList();
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: user?.length,
                            itemBuilder: (BuildContext, index) {
                              // return searchTitle(
                              //   userName: user?.elementAt(index).userName ?? 'empty',
                              //   user: user?.elementAt(index),
                              // );
                              return deafblindTitle(
                                  user: user!.elementAt(index));
                            });
                      }),
                )),
              ],
            ),
          ),
          onHorizontalSwipe: (SwipeDirection direction) {
            if (direction == SwipeDirection.left) {
              Navigator.pop(context);
              _vibrationInAction.vibrateInAction();
            } // return to the previous screen
          },
        ));
  }
}
