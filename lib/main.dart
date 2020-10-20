import 'package:ace_of_spades/home/home_screen.dart';
import 'package:ace_of_spades/login/login.dart';
import 'package:ace_of_spades/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        appBar: AppBar(),

        // TODO: dynamically pass title

        body: Login(),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 24,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.userAlt), label: 'Profile'),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.mapMarkedAlt), label: 'Map')
          ],
        ),
      )),
      routes: {},
    );
  }
}
