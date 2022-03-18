import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/chatDetails/RecievedMessageShow.dart';
import 'package:graduation_project/uIAndServices/chatDetails/sendMessagesShow.dart';
import 'package:provider/provider.dart';

class messageWidget extends StatelessWidget {
  messageData messageDataObject;

  messageWidget(this.messageDataObject);

  late authProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<authProvider>(context);
    return Container(
        child: messageDataObject.senderId == provider.user!.uID
            ? sendMessagesShow(messageDataObject.content,
                messageDataObject.dateTime.toString())
            : recievedMessageShow(messageDataObject.content,
                messageDataObject.dateTime.toString()));
  }
}
