import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/argData/athDataUtils.dart';
import 'package:graduation_project/uIAndServices/loginPackage/optionScreen.dart';
import 'package:graduation_project/utils/showMessage.dart';

class otpScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  static const String routName = 'otpTest';
  String verificationId = '';

  @override
  Widget build(BuildContext context) {
    var arg = (ModalRoute.of(context)?.settings.arguments) as athDataUtils;
    verificationId = arg.verification_Id;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 1, 87, 207),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: otpController,
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 0, 70, 168),
                  hintText: 'Enter OTP',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 70, 168)))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 15, 111, 255)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(15, 15)))),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    onPressed: () async {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpController.text);
                      signInWithCredential(phoneAuthCredential, context);
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }

  void signInWithCredential(
      PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        // Navigator.pushNamed(context, optionScreen.routeName);
        Navigator.pushNamedAndRemoveUntil(
            context, optionScreen.routeName, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      showMessage.show(context, e.toString());
    }
  }
}
