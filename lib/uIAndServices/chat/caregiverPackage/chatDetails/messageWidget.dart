import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/RecievedMessageShow.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/sendMessagesShow.dart';

class messageWidget extends StatelessWidget {
  messageData messageDataObject;

  messageWidget(this.messageDataObject);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        child: messageDataObject.senderId == localUserData.getUId()
            ? sendMessagesShow(messageDataObject.content,
                messageDataObject.dateTime.toString())
            : recievedMessageShow(messageDataObject.content,
                messageDataObject.dateTime.toString()));
  }
}
