import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:morse/morse.dart';
import 'package:vibration/vibration.dart';

class vibrateMessages extends vibrationInAction {
  void vibrateMessagesChat(List<String> listOfMessages) async {
    for (int i = 0; i <= listOfMessages.length - 1; i++) {
      var message = listOfMessages[i];
      final Morse morse = Morse(message);
      var messageInMorse = morse.encode();
      if (i > 0) {
        await Future.delayed(const Duration(milliseconds: 3000));
      }
      for (int i = 0; i < messageInMorse.length; i++) {
        if (messageInMorse[i] == '.') {
          await Vibration.vibrate(duration: 250);
          await Future.delayed(const Duration(milliseconds: 650));
        } else if (messageInMorse[i] == '-') {
          await Vibration.vibrate(duration: 500);
          await Future.delayed(const Duration(milliseconds: 650));
        } else if (messageInMorse[i] == ' ') {
          await Future.delayed(const Duration(milliseconds: 650));
        } else if (messageInMorse[i] == '/') {
          await Future.delayed(const Duration(milliseconds: 250));
        }
      }
    }
  }
}
