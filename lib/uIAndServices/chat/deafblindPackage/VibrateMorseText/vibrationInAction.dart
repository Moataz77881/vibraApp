import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrateInMorse.dart';
import 'package:vibration/vibration.dart';

class vibrationInAction extends vibrateInMorse {
  void vibrateInAction() {
    Vibration.vibrate(duration: 70);
  }
}
