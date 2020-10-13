import 'package:ace_of_spades/buttons/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  final Color backgroundColor = Color(0xFFDDDDDD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              //Avatar circle profile image
              backgroundImage: NetworkImage(''), // add route from google profile
              backgroundColor: Colors.white,
              radius: 64,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Firstname Lastname',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF9D170E),
              ),
            ), // pass argumwnt from login network name
            Text('email',
                style: TextStyle(
                  fontSize: 18,
                )),
            Text(
              'S16XXXX',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Bsc in physical science',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(
              height: 10,
            ),
            // TODO: seperate this button widget and refactor

            MenuButton(buttonIcon: FontAwesomeIcons.graduationCap, buttonText: 'Manage Courses'),
            MenuButton(buttonIcon: FontAwesomeIcons.font, buttonText: 'Grades'),
            MenuButton(buttonIcon: FontAwesomeIcons.clock, buttonText: 'Class Schedule'),
            MenuButton(buttonIcon: FontAwesomeIcons.clipboard, buttonText: 'Exam Schedule'),
            MenuButton(buttonIcon: FontAwesomeIcons.star, buttonText: 'Course Evaluation'),
            //MenuButton(buttonIcon: FontAwesomeIcons.signOutAlt, buttonText: 'Sign out'),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
