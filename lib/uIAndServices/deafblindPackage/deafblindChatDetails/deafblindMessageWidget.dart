import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatDetails/deafblindRecievedMessageShow.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatDetails/deafblindSendMessagesShow.dart';
import 'package:provider/provider.dart';

class deafblindMessageWidget extends StatelessWidget {
  messageData messageDataObject;

  deafblindMessageWidget({required this.messageDataObject});

  late authProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<authProvider>(context);

    return Container(
        child: messageDataObject.senderId == provider.user!.uID
            ? deafblindSendMessagesShow(
                content: messageDataObject.content,
                time: messageDataObject.dateTime.toString())
            : deafblindRecievedMessageShow(
                content: messageDataObject.content,
                time: messageDataObject.dateTime.toString()));
  }
}
