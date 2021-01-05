import 'dart:ui';

import 'package:flutter/material.dart';

class CourseSchedule {
  CourseSchedule._({this.courseCode, this.from, this.to, this.background, this.isAllDay, this.recurrenceRule});

  String courseCode;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String recurrenceRule;

  static CourseSchedule createCourseSchedule({Map<String, dynamic> scheduleDocument, Color backgroundColor}) {
    return CourseSchedule._(
        courseCode: scheduleDocument['course_code'],
        from: scheduleDocument['start_time'].toDate(),
        to: scheduleDocument['end_time'].toDate(),
        isAllDay: scheduleDocument['isAllDay'],
        background: backgroundColor,
        recurrenceRule: scheduleDocument['recur']
            ? 'FREQ=WEEKLY;INTERVAL=1;BYDAY=${scheduleDocument['weekday']};UNTIL=${scheduleDocument['recur_until']}'
            : null);
  }
}
