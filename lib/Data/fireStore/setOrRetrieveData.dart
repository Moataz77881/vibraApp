import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/Data/fireStore/dataStoreUtils.dart';

class setOrRetrieveData {
  static Future<void> addUser(userData user) {
    return userData
        .withConverter()
        .doc(user
            .uID) //uID is id of doc and it is the same id in the user authentication
        .set(user);
  } //makes new document in fire store and set information in it

  static Future<userData?> getDataById(String uID) async {
    DocumentSnapshot<userData> result = await userData
        .withConverter() // DocumentSnapshot contains data read from a document in my firestore
        .doc(uID) // get data by uID
        .get(); // read the document
    return result.data(); // get data form firestore
  }
}
