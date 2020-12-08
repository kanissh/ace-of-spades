import 'package:flutter/material.dart';

class ExamScheduleObject {
  final String courseCode; //course_code
  final DateTime startTime; //start_time
  final DateTime endTime; //end_time
  final String desc;

  ExamScheduleObject({@required this.courseCode, @required this.startTime, @required this.endTime, this.desc});
}
