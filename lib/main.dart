import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/splash.dart';

void main() async{
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      )
  );
}
