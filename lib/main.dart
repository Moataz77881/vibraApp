import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Data/localData/localUserData.dart';
import 'package:graduation_project/Data/provider/authProvider.dart';
import 'package:provider/provider.dart';

import 'myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await localUserData.init();
  runApp(ChangeNotifierProvider<authProvider>(
      create: (buildContext) => authProvider(),
      // callback function returns an object of class authProvider
      child: myApp()));
  // callback function returns an object of class authProvider
}