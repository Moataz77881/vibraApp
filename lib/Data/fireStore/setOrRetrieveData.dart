import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';

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

  static Future<void> addMessage(
      messageData message, String userId, String senderId) {
    var docRef = messageData
        .withConverter(userId, senderId)
        .doc(); //inside collection called messages add document
    message.id =
        docRef.id; // messages document id and message id are the same id
    return docRef.set(message); //set the message data in the document
  }
}
