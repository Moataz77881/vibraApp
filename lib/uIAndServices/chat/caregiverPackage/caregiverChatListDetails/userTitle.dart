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
        // print(user.picturePath);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 1, 87, 207),
                backgroundImage: user.picturePath == ''
                    ? null
                    : NetworkImage(user.picturePath),
                // backgroundImage: null,
                radius: 25,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(user.userName)
          ],
        ),
      ),
    );
  }
}
