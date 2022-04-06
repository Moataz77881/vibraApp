import 'package:flutter/material.dart';

class sendMessagesShow extends StatelessWidget {
  String content;
  String time;

  sendMessagesShow(this.content, this.time);

  // String result = DateTime.parse(time) as String;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Expanded(child: Text(time,textAlign: TextAlign.right,)),
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 1, 87, 207),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Text(
            content,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
