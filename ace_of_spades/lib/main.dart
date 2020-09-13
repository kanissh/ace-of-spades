import 'package:flutter/material.dart';
import 'package:ace_of_spades/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: SplashScreen()),
    );
  }
}
