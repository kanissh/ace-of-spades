import 'package:flutter/material.dart';

class GradesPage extends StatefulWidget {
  static String id = '/gradesPage';

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Grades work'),
      ),
    );
  }
}
