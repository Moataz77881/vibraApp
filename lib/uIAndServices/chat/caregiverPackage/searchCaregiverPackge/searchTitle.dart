import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/chatDetailsScreen.dart';

class searchTitle extends StatelessWidget {
  String userName;
  userData? user;

  searchTitle({required this.userName, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.all(3),
        child: Row(
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Container(
              // padding: EdgeInsets.all(),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 15, 111, 255)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(15, 15)))),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, chatDetailsScreen.routName,
                      arguments: user);
                },
                child: Text('message'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
