import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';

class messageData {
  static const String collectionNameUserMessage = 'userMessages';
  static const String collectionName = 'messages';
  String id;
  String content;
  DateTime dateTime;
  String senderId;

  messageData(
      {required this.id,
      required this.content,
      required this.dateTime,
      required this.senderId});

  messageData.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            content: json['content'] as String,
            dateTime:
                DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int),
            senderId: json['senderId'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'senderId': senderId
    };
  }

  static CollectionReference<messageData> withConverter(
      String userId, String senderId) {
    return userData
        .withConverter()
        .doc(userId) // to add new collection in user document
        .collection(collectionNameUserMessage)
        .doc(senderId)
        .collection(collectionName) // user messages
        .withConverter(
            fromFirestore: ((snapshot, options) =>
                messageData.fromJson(snapshot.data()!)),
            toFirestore: (messageData, _) => messageData.toJson());
  }
}
