import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateInMorse.dart';

class deafblindRecievedMessageShow extends StatelessWidget {
  String content;
  String time;
  vibrateInMorse _vibrateInMorse = new vibrateInMorse();

  deafblindRecievedMessageShow({required this.content, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            _vibrateInMorse.vibrateInMorseText(content);
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 222, 222),
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              content,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
