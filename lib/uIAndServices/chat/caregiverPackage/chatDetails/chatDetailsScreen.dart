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
  TextEditingController message = TextEditingController();

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
      body: Container(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      .withConverter(localUserData.getUId(), userDetails.uID)
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
                    var data =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (buildContext, index) {
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
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    controller: message,
                    onFieldSubmitted: (text) {
                      setState(() {
                        message.text = text;
                      });
                    },
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
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
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        sendMessage();
                      }
                    },
                    child: Row(
                      children: const [
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
        dateTime: messageDataObject.dateTime,
        senderId: messageDataObject.senderId,
        flag: 'false');

    userDataUsersList _userDataUsersListCurrentUser = userDataUsersList(
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
        _userDataUsersListCurrentUser);
  }
}
