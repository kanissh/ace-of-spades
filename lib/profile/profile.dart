import 'package:flutter/material.dart';

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
              backgroundImage:
                  NetworkImage(''), // add route from google profile
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

            // TODO: seperate this button widget and refactor

            TextButton(
              onPressed: () {},
              child: SizedBox(
                height: 44,
                child: Row(
                  children: [
                    Text(
                      'Manage Courses',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
