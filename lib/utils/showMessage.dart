import 'package:flutter/material.dart';

class showMessage {
  static void show(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
