import 'package:ace_of_spades/buttons/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  static String id = '/homePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MenuButton(buttonIcon: FontAwesomeIcons.calendar, buttonText: 'Academic Calender'),
            MenuButton(buttonIcon: FontAwesomeIcons.calendarDay, buttonText: 'Events'),
            MenuButton(buttonIcon: FontAwesomeIcons.book, buttonText: 'Course Search'),
            MenuButton(buttonIcon: FontAwesomeIcons.users, buttonText: 'Find People'),
            MenuButton(buttonIcon: FontAwesomeIcons.bullhorn, buttonText: 'Notices'),
            MenuButton(buttonIcon: FontAwesomeIcons.cog, buttonText: 'Settings'),
            MenuButton(buttonIcon: FontAwesomeIcons.solidCommentAlt, buttonText: 'Feedback')
          ],
        ),
      ),
    );
  }
}
