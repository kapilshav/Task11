import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'screens/home.dart';
import 'screens/log.dart';
import 'screens/reg.dart';
import 'screens/ter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget exp = SplashScreenView(
      imageSize: 150,
      imageSrc: 'images/logo1.png',
      text: "   Welcome to                 LI-TER",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 35.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      home: Log(),
      duration: 3000,
      backgroundColor: Colors.white,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: exp,
      routes: {
        "ter": (context) => Ter(),
        "home": (context) => Home(),
        "log": (context) => Log(),
        "reg": (context) => Reg(),
      },
    );
  }
}
