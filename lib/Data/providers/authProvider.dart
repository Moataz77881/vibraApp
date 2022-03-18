import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';

class authProvider extends ChangeNotifier {
  userData? user = null;

  authProvider() {
    fetchFireStoreUserData();
  }

  void updateUser(userData user) {
    this.user = user;
    notifyListeners(); // add listeners (user data) in the provider
  }

  bool isVerifyed() {
    return FirebaseAuth.instance.currentUser != null;
  } // to make sure the user is verified

  void fetchFireStoreUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var fireStoreUserData = await setOrRetrieveData
          .getDataById(FirebaseAuth.instance.currentUser!.uid);
      user = fireStoreUserData;
    }
  }
}
