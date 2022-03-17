import 'package:flutter/material.dart';
import 'package:graduation_project/Data/fireStore/dataStoreUtils.dart';

class chatDetailsScreen extends StatelessWidget {
  static const String routName = 'Chat details screen';
  late userData userDetails;

  @override
  Widget build(BuildContext context) {
    userDetails = ModalRoute.of(context)?.settings.arguments as userData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Text(
          userDetails.userName,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(),
    );
  }
}
