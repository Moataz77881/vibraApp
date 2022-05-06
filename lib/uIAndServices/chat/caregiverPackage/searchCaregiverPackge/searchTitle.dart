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
        // padding: const EdgeInsets.symmetric(horizontal: 40),
        margin: const EdgeInsets.all(3),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundImage: user!.picturePath == ''
                    ? null
                    : NetworkImage(user!.picturePath),
                backgroundColor: const Color.fromARGB(255, 1, 87, 207),
                radius: 28,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 15, 111, 255)),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(15, 15)))),
                padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, chatDetailsScreen.routName,
                    arguments: user);
                // print(user!.picturePath);
              },
              child: const Text('message'),
            )
          ],
        ),
      ),
    );
  }
}
