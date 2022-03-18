import 'package:flutter/material.dart';

class recievedMessageShow extends StatelessWidget {
  String content;
  String time;

  recievedMessageShow(this.content, this.time);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 222, 222),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Text(
            content,
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
