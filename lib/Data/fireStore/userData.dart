import 'package:cloud_firestore/cloud_firestore.dart';

class userData {
  static const String collectionName = 'users';
  String userName;
  String chooseMood;
  String phoneNumber;
  String uID;
  String picturePath;

  userData(
      {required this.userName,
      required this.phoneNumber,
      required this.uID,
      required this.chooseMood,
      required this.picturePath});

  userData.fromFireStore(Map<String, dynamic> json)
      : this(
            userName: json['userName'] as String,
            phoneNumber: json['phoneNumber'] as String,
            uID: json['uID'] as String,
            chooseMood: json['chooseMood'] as String,
            picturePath: json['picturePath'] as String);

  // get data from fire store
  Map<String, dynamic> toFireStore() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'uID': uID,
      'chooseMood': chooseMood,
      'picturePath': picturePath
    };
  }

  // send data to fire store

  static CollectionReference<userData> withConverter() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .withConverter<userData>(
            fromFirestore: (snapshot, _) =>
                userData.fromFireStore(snapshot.data()!),
            toFirestore: (user, _) => user.toFireStore());
  }
// this function connect with fire store and get or send data with userData opject

}
