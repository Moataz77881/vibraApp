import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/Data/fireStore/messageData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';

class userDataUsersList {
  String chooseMood;
  String uID;
  String phoneNumber;
  String userName;
  DateTime dateTime;
  String senderId;
  String flag;
  String picturePath;
  String lastMessage;

  userDataUsersList(
      {required this.uID,
      required this.userName,
      required this.phoneNumber,
      required this.dateTime,
      required this.chooseMood,
      required this.senderId,
      required this.flag,
      required this.picturePath,
      required this.lastMessage});

  userDataUsersList.fromFireStore(Map<String, dynamic> json)
      : this(
      userName: json['userName'] as String,
            phoneNumber: json['phoneNumber'] as String,
            uID: json['uID'] as String,
            chooseMood: json['chooseMood'] as String,
            dateTime:
                DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int),
            senderId: json['senderId'] as String,
            lastMessage: json['lastMessage'] as String,
            picturePath: json['picturePath'] as String,
            flag: json['flag'] as String);

  Map<String, dynamic> toFireStore() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'uID': uID,
      'chooseMood': chooseMood,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'senderId': senderId,
      'picturePath': picturePath,
      'flag': flag,
      'lastMessage': lastMessage
    };
  }

  static CollectionReference<userDataUsersList> withConverter(String userId) {
    return FirebaseFirestore.instance
        .collection(userData.collectionName)
        .doc(userId)
        .collection(messageData.collectionNameUserMessage)
        .withConverter<userDataUsersList>(
            fromFirestore: (snapshot, _) =>
                userDataUsersList.fromFireStore(snapshot.data()!),
            toFirestore: (user, _) => user.toFireStore());
  }
}
