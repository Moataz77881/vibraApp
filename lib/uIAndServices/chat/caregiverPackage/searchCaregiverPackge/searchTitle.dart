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
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: user!.picturePath == ''
                    ? null
                    : NetworkImage(user!.picturePath),
                backgroundColor: const Color.fromARGB(255, 53, 115, 234),
                radius: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          userName,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Text(
                          'I am using vibra',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // const Spacer(),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(
              //         const Color.fromARGB(255, 15, 111, 255)),
              //     shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(Radius.elliptical(15, 15)))),
              //     padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, chatDetailsScreen.routName,
              //         arguments: user);
              //     // print(user!.picturePath);
              //   },
              //   child: const Text('message'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
