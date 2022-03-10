import 'package:flutter/material.dart';

class showLoading {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 12,
                ),
                Text('Loading...')
              ],
            ),
          );
        },
        barrierDismissible: false // user cannot close the loading dialog
        );
  }
}
