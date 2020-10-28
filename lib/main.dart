import 'package:ace_of_spades/home/home_screen.dart';
import 'package:ace_of_spades/map/map_page.dart';
import 'package:ace_of_spades/signin/signin.dart';
import 'package:ace_of_spades/profile/profile.dart';
import 'package:ace_of_spades/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: SplashScreen(),
      )),
    );
  }
}
