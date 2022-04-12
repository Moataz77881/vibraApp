import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindRecievedMessageShow.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatDetails/deafblindSendMessagesShow.dart';

class deafblindMessageWidget extends StatelessWidget {
  messageData messageDataObject;

  deafblindMessageWidget({required this.messageDataObject});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: messageDataObject.senderId == localUserData.getUId()
            ? deafblindSendMessagesShow(
                content: messageDataObject.content,
                time: messageDataObject.dateTime.toString())
            : deafblindRecievedMessageShow(
                content: messageDataObject.content,
                time: messageDataObject.dateTime.toString()));
  }
}
