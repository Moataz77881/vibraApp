import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/loginPackage/loginScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/optionScreen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class textFieldBorderPhoneNumber extends StatelessWidget {
  static const String hintText = 'phone';
  static const routName = 'PhoneNumber';
  String initialCountry = 'EG';
  final PhoneNumber _number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          loginScreen.userPhoneNumber = number.toString();
          optionScreen.phoneNumber = number.toString();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Invalid phone number';
          }
        },
        cursorColor: Colors.white,
        keyboardType: TextInputType.phone,
        textStyle: TextStyle(color: Colors.white),
        inputDecoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 0, 70, 168),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 0, 70, 168)))),
        initialValue: _number,
        formatInput: true,
      ),
    );
  }
}
