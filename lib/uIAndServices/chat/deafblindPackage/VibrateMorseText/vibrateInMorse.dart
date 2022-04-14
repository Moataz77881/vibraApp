import 'package:morse/morse.dart';
import 'package:vibration/vibration.dart';

class vibrateInMorse {
  void vibrateInMorseText(String userName) {
    final Morse morse = Morse(userName);
    var userNameMorse = morse.encode();
    vibrationTheText(userNameMorse);
  }

  Future<void> vibrationTheText(String userNameMorse) async {
    for (int i = 0; i < userNameMorse.length; i++) {
      if (userNameMorse[i] == '.') {
        await Vibration.vibrate(duration: 250);
        await Future.delayed(const Duration(milliseconds: 650));
      } else if (userNameMorse[i] == '-') {
        await Vibration.vibrate(duration: 500);
        await Future.delayed(const Duration(milliseconds: 650));
      } else if (userNameMorse[i] == ' ') {
        await Future.delayed(const Duration(milliseconds: 725));
      } else if (userNameMorse[i] == '/') {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    }
  }
}
