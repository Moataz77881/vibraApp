import 'package:flutter/material.dart';

class textFieldBorder extends StatelessWidget {
  String hintText;
  textFieldBorder(this.hintText);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 0, 70, 168),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 70, 168)
                )
            )
        ),
      ),
    );
  }
}
