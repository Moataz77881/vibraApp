import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/UI/textFieldBorderPhone.dart';
import 'package:graduation_project/UI/textFieldBorderUsername.dart';

class loginScreen extends StatelessWidget {
  static const String routeName = 'Login Screen';
  static String userPhoneNumber = '';
  static String userName = '';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 87, 207),
      // #0046A8 Inputs #0F6FFF continue button
      body: Form(
        key: formKey,
        child: Container(
          child: Column(
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
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            formValidation(userPhoneNumber, userName);
                            // Navigator.pushNamed(
                            //     context, optionScreen.routeName);
                          }
                        },
                        child: Text('Continue'),
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

  void formValidation(String number, String UserName) {}
}
