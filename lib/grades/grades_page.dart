import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/grades/student_course_tile.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  String currentGpa = '4.00';

  StudentCourse _studentCourse = StudentCourse(
      code: 'CS 313',
      name: 'Digital Image Processing',
      credits: '3',
      grade: 'A+');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                currentGpa,
                style: TextStyle(fontSize: 53),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                StudentCourseTile(studentCourse: _studentCourse),
                StudentCourseTile(studentCourse: _studentCourse)
              ],
            ),
            flex: 5,
          )
        ],
      ),
    ));
  }
}
