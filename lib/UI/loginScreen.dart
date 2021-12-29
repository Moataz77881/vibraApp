import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/data.dart';
import 'package:graduation_project/UI/optionScreen.dart';
import 'package:graduation_project/UI/otpScreen.dart';
import 'package:graduation_project/UI/textFieldBorderPhone.dart';
import 'package:graduation_project/UI/textFieldBorderUserName.dart';

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
                            await _firebaseAuth.verifyPhoneNumber(
                              phoneNumber: userPhoneNumber,
                              verificationCompleted:
                                  (phoneAuthCredential) async {
                                await _firebaseAuth
                                    .signInWithCredential(phoneAuthCredential)
                                    .then((value) {
                                  Navigator.pushNamed(
                                      context, optionScreen.routeName);
                                }).onError((error, stackTrace) {
                                  print('Account creation error');
                                }).timeout(Duration(seconds: 10),
                                        onTimeout: () {
                                  print('cannot connect to server');
                                });
                              },
                              verificationFailed: (verificationFailed) async {
                                print(verificationFailed.message);
                              },
                              codeSent: (verificationId, resendingToken) async {
                                Navigator.pushNamed(context, otpScreen.routName,
                                    arguments:
                                        data(verification_Id: verificationId));
                              },
                              codeAutoRetrievalTimeout: (verificationId) {},
                            );
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
