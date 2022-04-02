import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/argData/athDataUtils.dart';
import 'package:graduation_project/uIAndServices/optionScreen.dart';
import 'package:graduation_project/uIAndServices/otpScreen.dart';
import 'package:graduation_project/uIAndServices/textFieldBorderPhone.dart';
import 'package:graduation_project/uIAndServices/textFieldBorderUserName.dart';
import 'package:graduation_project/utils/hideLoading.dart';
import 'package:graduation_project/utils/showLoading.dart';
import 'package:graduation_project/utils/showMessage.dart';

class loginScreen extends StatelessWidget {
  static const String routeName = 'Login Screen';
  static String userPhoneNumber = '';
  static String userName = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 1, 87, 207),
      // #0046A8 Inputs #0F6FFF continue button
      body: Form(
        key: formKey,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              Container(
                child: Image.asset(
                  "assets/images/vibra.png",
                  width: 200,
                  height: 200,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 11),
                  child: textFieldBorderUsername()),
              textFieldBorderPhoneNumber(),
              Container(
                margin: EdgeInsets.all(11),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 15, 111, 255)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(15, 15)))),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                        ),
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            showLoading.show(context);
                            await _firebaseAuth.verifyPhoneNumber(
                              // when the sms code is delivered the android will automatically verify the SMS code without requiring the user to manually input the code.
                              phoneNumber: userPhoneNumber,
                              verificationCompleted:
                                  (phoneAuthCredential) async {
                                    // which can be used to sign in
                                await _firebaseAuth
                                    .signInWithCredential(phoneAuthCredential)
                                    .then((value) {
                                  Navigator.pushNamed(
                                      context, optionScreen.routeName);
                                }).onError((error, stackTrace) {
                                  showMessage.show(context,
                                      'Account creation error'); // show dialog message
                                }).timeout(Duration(seconds: 10),
                                        onTimeout: () {
                                  showMessage.show(context,
                                      'cannot connect to server'); // show dialog message
                                });
                              },
                              verificationFailed: (verificationFailed) {
                                if (verificationFailed.message != null) {
                                  showMessage.show(context,
                                      'verfication failed please try again');
                                  hideLoading.hide(context);
                                }
                              },
                              codeSent: (verificationId, resendingToken) async {
                                await Navigator.pushNamed(
                                    context, otpScreen.routName,
                                    arguments: athDataUtils(
                                        verification_Id: verificationId));
                              },
                              codeAutoRetrievalTimeout: (verificationId) {},
                            );
                            if (_firebaseAuth.currentUser != null) {
                              optionScreen.uID = _firebaseAuth.currentUser!.uid;
                            }
                          }
                        },
                        child: Text('Verify'),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
