import 'package:ace_of_spades/profile/profile.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          child: Scaffold(
        body: ProfilePage(),
        //bottomNavigationBar: BottomNavigationBar(),
      )),
      routes: {},
    );
  }
}
