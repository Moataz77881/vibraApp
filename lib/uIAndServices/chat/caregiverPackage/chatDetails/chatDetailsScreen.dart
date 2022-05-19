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
  String lastMessage = '';

  @override
  Widget build(BuildContext context) {
    userDetails = ModalRoute.of(context)?.settings.arguments as userData;
    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        elevation: .5,
        backgroundColor: const Color.fromARGB(200, 250, 250, 251),
        titleSpacing: -10,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: userDetails.picturePath == ''
                  ? null
                  : NetworkImage(userDetails.picturePath),
              backgroundColor: Color.fromARGB(255, 53, 115, 234),
              radius: 22,
              // child: Image.asset('assets/images/backgroundUser.webp',),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  userDetails.userName,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 53, 115, 234),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(206, 250, 250, 251),
        child: Column(
          children: [
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
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Row(
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
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Type your message',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  // color: Color.fromARGB(190, 170, 170, 170),
                                  color: Colors.white,
                                  width: 2),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)))),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 15,
                  // ),
                  SizedBox(
                    width: 52,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (message.text.isNotEmpty) {
                            sendMessage();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shadowColor: Colors.white,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70)))),
                        child: Row(
                          children: const [
                            // Text(
                            //   'send',
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            // SizedBox(
                            //   width: 8,
                            // ),
                            Icon(
                              Icons.send,
                              color: Color.fromARGB(255, 53, 115, 234),
                              size: 20,
                            )
                          ],
                        )),
                  )
                ],
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
        lastMessage: messageDataObject.content,
        uID: userDetails.uID,
        dateTime: messageDataObject.dateTime,
        senderId: messageDataObject.senderId,
        picturePath:
            userDetails.picturePath.isEmpty ? '' : userDetails.picturePath,
        flag: 'false');

    userDataUsersList _userDataUsersListCurrentUser = userDataUsersList(
        userName: localUserData.getUserName(),
        phoneNumber: localUserData.getPhoneNumber(),
        chooseMood: localUserData.getChooseMood(),
        uID: localUserData.getUId(),
        dateTime: messageDataObject.dateTime,
        senderId: messageDataObject.senderId,
        lastMessage: messageDataObject.content,
        picturePath: localUserData.getPicturePath().isEmpty
            ? ''
            : localUserData.getPicturePath(),
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
