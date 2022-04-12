import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/chat/caregiverPackage/searchCaregiverPackge/searchTitle.dart';

class searchScreen extends StatefulWidget {
  static const String routName = 'search screen';

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  late QuerySnapshot searchSnapshot;
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Image.asset(
          "assets/images/vibra.png",
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(190, 234, 233, 233),
                          filled: true,
                          hintText: 'Search',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: searchList(name))
          ],
        ),
      ),
    );
  }

  Widget searchList(String _userNameEditingController) {
    return StreamBuilder<QuerySnapshot<userData>>(
        stream: userData
            .withConverter()
            .where('userName', isEqualTo: _userNameEditingController)
            .snapshots(),
        builder: (builder, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var user = snapshot.data?.docs.map((e) => e.data()).toList();
          return ListView.builder(
              shrinkWrap: true,
              itemCount: user?.length,
              itemBuilder: (BuildContext, index) {
                return searchTitle(
                  userName: user?.elementAt(index).userName ?? 'empty',
                  user: user?.elementAt(index),
                );
              });
        });
  }
}
