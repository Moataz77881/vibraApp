import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/providers/authProvider.dart';
import 'package:provider/provider.dart';

import 'myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<authProvider>(
      create: (BuildContext) => authProvider(),
      // callback function returns an object of class authProvider
      child: myApp()));
}