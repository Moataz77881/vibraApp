import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:graduation_project/uIAndServices/deafblindPackage/deafblindChatList/deafblindUserTitle.dart';
import 'package:provider/provider.dart';

class deafblindChatList extends StatelessWidget {
  static const String routName = 'deafblindChatList';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<authProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        centerTitle: true,
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 87, 207),
                      borderRadius: BorderRadius.circular(40)),
                  child: Center(
                      child: Text(
                    provider.user != null
                        ? provider.user!.userName.substring(0, 1)
                        : deafblindChatList.routName,
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    provider.user != null
                        ? provider.user!.userName
                        : deafblindChatList.routName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    color: Colors.grey,
                    width: 2,
                    height: 2,
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot<userData>>(
              stream: userData.withConverter().snapshots(),
              builder: (builder, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var user = snapshot.data!.docs.map((e) => e.data()).toList();

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.length,
                    itemBuilder: (BuildContext, index) {
                      return deafblindUserTitle(
                        user: user.elementAt(index),
                      );
                    });
              },
            )))
          ],
        ),
      ),
    );
  }
}
