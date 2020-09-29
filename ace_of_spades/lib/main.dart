import 'package:flutter/material.dart';
import 'package:ace_of_spades/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF9D170E),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SafeArea(child: SplashScreen()),
    );
  }
}
