import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/caregiverChatListDetails/userTitle.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/searchCaregiverPackge/searchScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/splashScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class caregiverChatList extends StatefulWidget {
  static const String routName = 'caregiverChatList';

  @override
  State<caregiverChatList> createState() => _caregiverChatListState();
}

class _caregiverChatListState extends State<caregiverChatList> {
  String _Image = '';
  // PlatformStringCryptor cryptor = PlatformStringCryptor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 115, 234),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 53, 115, 234),
        centerTitle: true,
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (buildContext) => [
                    PopupMenuItem(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            // backgroundImage: _Image.isEmpty ? null : FileImage(File(_Image)),
                            backgroundImage: localUserData.getPicturePath() ==
                                    ''
                                ? null
                                : NetworkImage(localUserData.getPicturePath()),
                            backgroundColor: const Color.fromRGBO(
                                208, 207, 207, 0.8588235294117647),
                            radius: 30,
                          ),
                        ),
                        GestureDetector(
                            onTap: pickImageWithCamera,
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ))
                      ],
                    )),
                    PopupMenuItem(
                      onTap: uploadImageToStorage,
                      child: const Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, splashScreen.routname, (route) => false);
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 53, 115, 234),
        onPressed: () {
          Navigator.pushNamed(context, searchScreen.routName);
        },
        child: const Icon(Icons.search),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: CircleAvatar(
                  backgroundImage: localUserData.getPicturePath() == ''
                      ? null
                      : NetworkImage(localUserData.getPicturePath()),
                  backgroundColor: Colors.white,
                  radius: 25,
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Chats',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Text(
              //     localUserData.getUserName(),
              //     style: const TextStyle(
              //         fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         margin: const EdgeInsets.only(bottom: 8),
          //         color: Colors.grey,
          //         width: 2,
          //         height: 2,
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            // margin: EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: StreamBuilder<QuerySnapshot<userDataUsersList>>(
              stream: userDataUsersList
                  .withConverter(localUserData.getUId())
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (builder, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var user = snapshot.data!.docs
                        .map((e) => e.data())
                        .toList(); // userDataList

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: user.length,
                        itemBuilder: (buildContext, index) {
                          var _user = userData(
                          userName: user.elementAt(index).userName,
                          phoneNumber: user.elementAt(index).phoneNumber,
                          uID: user.elementAt(index).uID,
                          chooseMood: user.elementAt(index).chooseMood,
                          picturePath: user.elementAt(index).picturePath);
                      return userTitle(
                        user: _user,
                        lastMessage: user.elementAt(index).lastMessage,
                      );
                    });
              },
            ),
          ))
        ],
      ),
    );
  }

  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _Image = image.path;
      });
    }
  }

  void pickImageWithCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _Image = image.path;
        print(_Image);
      });
    }
  }

  void uploadImageToStorage() async {
    if (_Image.isNotEmpty) {
      String path = basename(_Image);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(_Image);
      UploadTask upload = ref.putFile(File(_Image));
      TaskSnapshot snapshot = await upload.whenComplete(() => null);
      snapshot.ref.getDownloadURL().then((value) {
        localUserData.setPicturePath(value);
        setOrRetrieveData.addUser(userData(
            userName: localUserData.getUserName(),
            phoneNumber: localUserData.getPhoneNumber(),
            uID: localUserData.getUId(),
            chooseMood: localUserData.getChooseMood(),
            picturePath: value));
        print(value);
        print('Done');
      });
    }
  }
// void encrypt()async{
//   var cryptor = await PlatformStringCryptor();
//   String key = await cryptor.generateKeyFromPassword('moataz', 'sssss12');
//   print(key);
//   String ecrypted = await cryptor.encrypt('moataz', key);
//   String encryptedString = ecrypted;
//   print(encryptedString);
// }
}
