import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/fireStore/userDataUsersList.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/caregiverChatListDetails/userTitle.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/searchCaregiverPackge/searchScreen.dart';
import 'package:graduation_project/uIAndServices/loginPackage/splashScreen.dart';

class caregiverChatList extends StatelessWidget {
  static const String routName = 'caregiverChatList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 87, 207),
        centerTitle: true,
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (buildContext) => [
                    PopupMenuItem(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, splashScreen.routname, (route) => false);
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, searchScreen.routName);
        },
        child: const Icon(Icons.search),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 87, 207),
                      borderRadius: BorderRadius.circular(40)),
                  child: Center(
                      child: Text(
                    localUserData.getUserName().substring(0, 1),
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    localUserData.getUserName(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: Colors.grey,
                    width: 2,
                    height: 2,
                  ),
                ),
              ],
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot<userDataUsersList>>(
              stream: userDataUsersList
                  .withConverter(localUserData.getUId())
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (builder, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var user = snapshot.data!.docs
                    .map((e) => e.data())
                    .toList(); // userDataList

                    return ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.length,
                    itemBuilder: (buildContext, index) {
                      var _user = userData(
                          userName: user.elementAt(index).userName,
                          phoneNumber: user.elementAt(index).phoneNumber,
                          uID: user.elementAt(index).uID,
                          chooseMood: user.elementAt(index).chooseMood);
                      return userTitle(
                        user: _user,
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}
