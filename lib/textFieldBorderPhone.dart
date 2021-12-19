import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class textFieldBorderPhoneNumber extends StatelessWidget {
  static const String hintText = 'phone';
  String userNumber = '';
  static const routName = 'PhoneNumber';
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {},
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
        initialValue: number,
        formatInput: true,
      ),
    );
  }
}
