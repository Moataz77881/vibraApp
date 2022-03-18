import 'package:flutter/material.dart';

class recievedMessageShow extends StatelessWidget {
  String content;
  String time;

  recievedMessageShow(this.content, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(content),
    );
  }
}
