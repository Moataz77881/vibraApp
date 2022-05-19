import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/chatDetails/chatDetailsScreen.dart';

class userTitle extends StatelessWidget {
  userData user;
  String lastMessage;

  userTitle({required this.user, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return const Color.fromARGB(255, 218, 218, 218);
          } else {
            return Colors.white;
          }
        }), elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return 20;
          } else {
            return 0;
          }
        })),
        onPressed: () {
          Navigator.pushNamed(context, chatDetailsScreen.routName,
              arguments: user);
        },
        child: Container(
          // padding: const EdgeInsets.all(5),
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 53, 115, 234),
                backgroundImage: user.picturePath == ''
                    ? null
                    : NetworkImage(user.picturePath),
                // backgroundImage: null,
                radius: 25,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.userName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lastMessage,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
