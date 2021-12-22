import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttonOption.dart';

class optionScreen extends StatelessWidget {

  static const String routeName = 'option Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Image.asset('assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [

            Expanded(
                flex: 6,
                child: buttonOption('I am Blind - Deaf')
            ),

            Expanded(
                flex: 4,
                child: buttonOption('I am Caregiver')
            )
          ],
        ),
      ),
    );
  }
}
