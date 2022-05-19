import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateInMorse.dart';

class deafblindSendMessagesShow extends StatelessWidget {
  String content;
  String time;

  deafblindSendMessagesShow({required this.content, required this.time});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        vibrateInMorse _vibrateInMorse = new vibrateInMorse();
        _vibrateInMorse.vibrateInMorseText(content);
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expanded(child: Text(time,textAlign: TextAlign.right,)),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 15, 111, 255),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Text(
                content,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
