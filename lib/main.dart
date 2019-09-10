import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/home.dart';
import 'view/login.dart';
import 'view/splash.dart';

void main() async{
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
        routes: {
          '/login' : (context) => Login(),
          '/home' : (context) => Home(),
        },
      )
  );
}
