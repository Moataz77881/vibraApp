import 'package:flutter/material.dart';

class textFieldBorderUsername extends StatefulWidget {
  static const String hintText = 'User name';

  @override
  State<textFieldBorderUsername> createState() =>
      _textFieldBorderUsernameState();
}

class _textFieldBorderUsernameState extends State<textFieldBorderUsername> {
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 0, 70, 168),
            hintText: textFieldBorderUsername.hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 0, 70, 168)))),
        onChanged: (value) {
          userName = value;
          // setState(() {});
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            // (trim) when user enter spaces in text form
            return 'Please enter user name';
          } else
            return null;
        },
      ),
    );
  }
}
