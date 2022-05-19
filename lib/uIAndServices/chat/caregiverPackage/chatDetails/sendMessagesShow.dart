import 'package:flutter/material.dart';

class sendMessagesShow extends StatelessWidget {
  String content;
  String time;

  sendMessagesShow(this.content, this.time);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: Container()),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 64, 120, 234),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Text(
            content,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
