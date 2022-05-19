import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/loginPackage/optionScreen.dart';

class textFieldBorderUsername extends StatelessWidget {
  static const String hintText = 'user name';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.elliptical(15, 15))
      // ),\
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.elliptical(15, 15))
      // ),
      child: TextFormField(
        autofocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(234, 233, 233, 0.7450980392156863),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                borderSide: BorderSide(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                ))),
        onChanged: (inputName) {
          optionScreen.userName = inputName;
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            // (trim) when user enter spaces in text form
            return 'Please enter user name';
          }
          return null;
        },
      ),
    );
  }
}
