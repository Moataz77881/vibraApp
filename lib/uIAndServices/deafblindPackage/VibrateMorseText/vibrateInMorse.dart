import 'package:morse/morse.dart';
import 'package:vibration/vibration.dart';

class vibrateInMorse {
  void vibrateInMorseText(String userName) {
    final Morse morse = new Morse(userName);
    var userNameMorse = morse.encode();
    vibrationTheText(userNameMorse);
  }

  Future<void> vibrationTheText(String userNameMorse) async {
    for (int i = 0; i < userNameMorse.length; i++) {
      if (userNameMorse[i] == '.') {
        await Vibration.vibrate(duration: 300);
        await Future.delayed(const Duration(milliseconds: 1150));
      } else if (userNameMorse[i] == '-') {
        await Vibration.vibrate(duration: 600);
        await Future.delayed(const Duration(milliseconds: 1150));
      } else if (userNameMorse[i] == ' ') {
        await Future.delayed(const Duration(milliseconds: 1400));
      } else if (userNameMorse[i] == '/') {
        await Future.delayed(const Duration(milliseconds: 1600));
      }
    }
  }
}
