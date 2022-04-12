import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/chatDetailsScreen.dart';

class userTitle extends StatelessWidget {
  userData user;

  userTitle({required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, chatDetailsScreen.routName,
            arguments: user);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 87, 207),
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                  child: Text(
                user.userName.substring(0, 1),
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              width: 8,
            ),
            Container(child: Text(user.userName))
          ],
        ),
      ),
    );
  }
}
