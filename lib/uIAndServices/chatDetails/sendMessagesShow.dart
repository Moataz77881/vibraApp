import 'package:flutter/material.dart';

class sendMessagesShow extends StatelessWidget {
  String content;
  String time;

  sendMessagesShow(this.content, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(content),
    );
  }
}
