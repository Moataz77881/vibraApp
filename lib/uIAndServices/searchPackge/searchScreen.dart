import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/Data/fireStore/userData.dart';
import 'package:graduation_project/uIAndServices/searchPackge/searchTitle.dart';

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
      backgroundColor: Color.fromARGB(190, 250, 250, 250),
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                      // controller: userNameEditingController ,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(12, 12)),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [
                            const Color.fromARGB(255, 255, 255, 255),
                            const Color.fromARGB(255, 255, 255, 255),
                          ])),
                      child: Image.asset(
                        'assets/images/search-icon.webp',
                        width: 35,
                        height: 35,
                      ),
                    ),
                  )
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
