import 'package:shared_preferences/shared_preferences.dart';

class localUserData {
  static const userNameKey = 'userName';
  static const phoneNumberKey = 'phoneNumber';
  static const uIdKey = 'uId';
  static const chooseMoodKey = 'chooseMood';

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
}
