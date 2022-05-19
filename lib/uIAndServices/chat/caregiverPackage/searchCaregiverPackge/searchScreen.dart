import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: const Color.fromARGB(206, 250, 250, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 115, 234),
        title: Image.asset(
          "assets/images/vibra.png",
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      // padding: EdgeInsets.all(1),
                      height: 50,
                      child: TextFormField(
                        textInputAction: TextInputAction.newline,
                        autofocus: true,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            fillColor: Color.fromARGB(190, 234, 233, 233),
                            filled: true,
                            hintText: 'Search',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            // hintStyle: TextStyle(fontStyle: ),
                            // hintStyle: TextStyle(fontSize: 20),
                            // helperStyle: TextStyle(fontSize: 100),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
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
            return const Center(
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
