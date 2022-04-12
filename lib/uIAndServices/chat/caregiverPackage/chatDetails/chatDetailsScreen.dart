import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/messageWidget.dart';

class chatDetailsScreen extends StatefulWidget {
  static const String routName = 'Chat details screen';

  @override
  State<chatDetailsScreen> createState() => _chatDetailsScreenState();
}

class _chatDetailsScreenState extends State<chatDetailsScreen> {
  late userData userDetails;
  TextEditingController message = new TextEditingController();

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
      body: Container(
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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(userDetails.userName,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
                      .withConverter(localUserData.getUId(), userDetails.uID)
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
                    var data =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext, index) {
                          return messageWidget(data[index]);
                        });
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: message,
                    onFieldSubmitted: (text) {
                      setState(() {
                        message.text = text;
                      });
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(190, 234, 233, 233),
                        filled: true,
                        hintText: 'Type your message',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(190, 170, 170, 170),
                                width: 2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12)))),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        sendMessage();
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.send)
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() async {
    messageData messageDataObject = messageData(
        id: '',
        content: message.text,
        dateTime: DateTime.now(),
        senderId: localUserData.getUId());

    setState(() {
      message.text = '';
    });

    userDataUsersList _userDataUsersList = userDataUsersList(
        userName: userDetails.userName,
        phoneNumber: userDetails.phoneNumber,
        chooseMood: userDetails.chooseMood,
        uID: userDetails.uID,
        dateTime: messageDataObject.dateTime);

    userDataUsersList _userDataUsersListCurrentUser = userDataUsersList(
        userName: localUserData.getUserName(),
        phoneNumber: localUserData.getPhoneNumber(),
        chooseMood: localUserData.getChooseMood(),
        uID: localUserData.getUId(),
        dateTime: messageDataObject.dateTime);

    var result1 = await setOrRetrieveData.addMessage(messageDataObject,
        userDetails.uID, messageDataObject.senderId); // id bta3 mohab
    var result2 = await setOrRetrieveData.addMessage(
        messageDataObject, messageDataObject.senderId, userDetails.uID);
    setOrRetrieveData.getChatList(
        messageDataObject.senderId, userDetails.uID, _userDataUsersList);
    setOrRetrieveData.getChatList(userDetails.uID, messageDataObject.senderId,
        _userDataUsersListCurrentUser);
  }
}
