import 'package:shared_preferences/shared_preferences.dart';

class localUserData {
  static const userNameKey = 'userName';
  static const phoneNumberKey = 'phoneNumber';
  static const uIdKey = 'uId';
  static const chooseMoodKey = 'chooseMood';
  static const picturePath = 'picturePath';

  // static const picturePathDevice = 'picturePathDevice';

  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setUserData(String userName, String phoneNumber,
      String uId, String chooseMood) async {
    await _preferences.setString(userNameKey, userName);
    await _preferences.setString(phoneNumberKey, phoneNumber);
    await _preferences.setString(uIdKey, uId);
    await _preferences.setString(chooseMoodKey, chooseMood);
  }

  static Future<void> setPicturePath(String path) async {
    await _preferences.setString(picturePath, path);
  }

  // static Future<void> setPicturePathDevice(String path){
  //   return _preferences.setString(picturePathDevice, path);
  // }

  static String getUserName() {
    return _preferences.getString(userNameKey) as String;
  }

  static String getPhoneNumber() {
    return _preferences.getString(phoneNumberKey) as String;
  }

  static String getUId() {
    return _preferences.getString(uIdKey) as String;
  }

  static String getChooseMood() {
    return _preferences.getString(chooseMoodKey) as String;
  }

  static String getPicturePath() {
    return _preferences.getString(picturePath) as String;
  }
// static String getPicturePathDevice(){
//   return _preferences.getString(picturePathDevice) as String;
// }
}
