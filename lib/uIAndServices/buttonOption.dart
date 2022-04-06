import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/setOrRetrieveData.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/caregiverListDetails/caregiverChatList.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatList/deafblindChatList.dart';
import 'package:graduation_project/utils/showLoading.dart';
import 'package:graduation_project/utils/showMessage.dart';
import 'package:provider/provider.dart';

class buttonOption extends StatelessWidget {
  String option;
  String userName;
  String phoneNumber;
  String uID;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late authProvider provider;

  buttonOption(this.uID, this.userName, this.phoneNumber, this.option);

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<authProvider>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(12),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 1, 87, 207)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
                                chooseMood: option))
                        .then((value) async {
                      var fireStoreUser = await setOrRetrieveData
                          .getDataById(_firebaseAuth.currentUser!.uid);
                      if (fireStoreUser != null) {
                        //todo provider
                        provider.updateUser(fireStoreUser);
                        if (option == 'I am Caregiver') {
                          showLoading();
                          showMessage.show(
                              context, 'account created successfully');
                          Navigator.pushReplacementNamed(
                              context,
                              caregiverForeChatList
                                  .routName); //push to the next screen without back to the register screen
                        } else if (option == 'I am Blind - Deaf') {
                          showMessage.show(
                              context, 'account created successfully');
                          Navigator.pushReplacementNamed(
                              context,
                              deafblindChatList
                                  .routName); //push to the next screen without back to the register screen
                        }
                      }
                    }).onError((error, stackTrace) {
                      showMessage.show(context, error.toString());
                    });
                  }
                },
                child: Text(
                  option,
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ),
      ],
    );
  }
}
