import 'package:flutter/material.dart';

class searchScreen extends StatelessWidget {
  static const String routName = 'search screen';

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
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(12, 12)),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                  Container(
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
