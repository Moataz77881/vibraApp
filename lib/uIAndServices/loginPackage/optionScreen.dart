import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttonOption.dart';

class optionScreen extends StatelessWidget {

  static const String routeName = 'option Screen';
  static String userName = '';
  static String phoneNumber = '';
  static String uID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 111, 255),
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: buttonOption(
                  uID, userName, phoneNumber, 'I am Blind - Deaf')),
          Expanded(
              child: buttonOption(uID, userName, phoneNumber, 'I am Caregiver'))
        ],
      ),
    );
  }
}
