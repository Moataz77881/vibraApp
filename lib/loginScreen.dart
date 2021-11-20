import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/optionScreen.dart';
import 'package:graduation_project/textFieldBorder.dart';

class loginScreen extends StatelessWidget {
  static const String routeName = 'Login Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 87, 207), // #0046A8 Inputs #0F6FFF continue button

      body: Container(
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
            Spacer(
              flex: 1,
            ),

            textFieldBorder('Email'),

            SizedBox(
              height: 10,
            ),

            textFieldBorder('Phone'),

            SizedBox(
              height: 5,
            ),

            Container(
              margin: EdgeInsets.all(11),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                            255, 15, 111, 255)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.elliptical(15, 15))
                        )),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      ),
                      onPressed: ()=> Navigator.pushNamed(context, optionScreen.routeName),
                      child: Text('Continue'),
                    ),
                  ),
                ],
              ),
            ), // Continue Button

            Container(
              child: TextButton(
                onPressed: () {  },
                child: Text('Emergency Call',style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ), // Emergency Call button

            Spacer(flex: 5,)
          ],
        ),
      ),
    );
  }
}
