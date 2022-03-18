import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/chatDetails/messageWidget.dart';
import 'package:provider/provider.dart';

class chatDetailsScreen extends StatefulWidget {
  static const String routName = 'Chat details screen';

  @override
  State<chatDetailsScreen> createState() => _chatDetailsScreenState();
}

class _chatDetailsScreenState extends State<chatDetailsScreen> {
  late userData userDetails;
  TextEditingController message = new TextEditingController();
  late authProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<authProvider>(context);
    userDetails = ModalRoute.of(context)?.settings.arguments as userData;
    return Scaffold(
      // backgroundColor: Color.fromARGB(190, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Text(
          userDetails.userName,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                child: StreamBuilder<QuerySnapshot<messageData>>(
                  stream: messageData
                      .withConverter(userDetails.uID, provider.user!.uID)
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
                      sendMessage();
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
        senderId: provider.user!.uID);

    setState(() {
      message.text = '';
    });

    var result1 = await setOrRetrieveData.addMessage(messageDataObject,
        userDetails.uID, messageDataObject.senderId); // id bta3 mohab
    var result2 = await setOrRetrieveData.addMessage(
        messageDataObject, messageDataObject.senderId, userDetails.uID);
  }
}
