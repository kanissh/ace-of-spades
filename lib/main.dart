import 'package:ace_of_spades/grades/grades_page.dart';
import 'package:ace_of_spades/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: Colors.white,
        )),
        primaryColor: Color(0xFF9D170E),
        scaffoldBackgroundColor: Colors.white,
        // TODO: define TextStyleTheme for body, heading and others
        fontFamily: 'OpenSans',
      ),
      home: SafeArea(
        child: SplashScreen(),
      ),
      routes: {
        GradesPage.id: (context) => GradesPage(),
      },
    );
  }
}

