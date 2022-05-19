import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/caregiverChatListDetails/caregiverChatList.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/deafblindChatList/deafblindChatList.dart';
import 'package:graduation_project/utils/showLoading.dart';
import 'package:graduation_project/utils/showMessage.dart';

class buttonOption extends StatelessWidget {
  String option;
  String userName;
  String phoneNumber;
  String uID;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  buttonOption(this.uID, this.userName, this.phoneNumber, this.option);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 15, 111, 255)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                  )),
                ),
                onPressed: () {
                  if (_firebaseAuth.currentUser != null) {
                    setOrRetrieveData
                        .addUser(// to add the data of user in fire store
                            userData(
                                // constructor to assign data
                                userName: userName,
                                phoneNumber: phoneNumber,
                                uID: _firebaseAuth.currentUser!.uid,
                                chooseMood: option,
                                picturePath: ''))
                        .then((value) async {
                      var fireStoreUser = await setOrRetrieveData
                          .getDataById(_firebaseAuth.currentUser!.uid);
                      // fireStoreUser.
                      if (fireStoreUser != null) {
                        // todo save user data in local device
                        localUserData.setUserData(userName, phoneNumber,
                            _firebaseAuth.currentUser!.uid, option);
                        localUserData.setPicturePath('');
                        if (option == 'I am Caregiver') {
                          showLoading();
                          showMessage.show(
                              context, 'account created successfully');
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              caregiverChatList.routName,
                              (route) =>
                                  false); //push to the next screen without back to the register screen
                        } else if (option == 'I am Blind - Deaf') {
                          showMessage.show(
                              context, 'account created successfully');
                          Navigator.pushNamedAndRemoveUntil(context,
                              deafblindChatList.routName, (route) => false);
                        }
                      }
                    }).onError((error, stackTrace) {
                      showMessage.show(context, error.toString());
                    });
                  }
                },
                child: Text(
                  option,
                  style: const TextStyle(fontSize: 20),
                )),
          ),
        ),
      ],
    );
  }
}
