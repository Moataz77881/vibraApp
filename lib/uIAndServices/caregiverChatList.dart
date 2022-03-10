import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/searchScreen.dart';

class caregiverForeChatList extends StatelessWidget {
  static const String routName = 'caregiverForeChatList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        centerTitle: true,
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, searchScreen.routName);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
