import 'dart:ui';

class CourseSchedule {
  CourseSchedule({this.courseCode, this.from, this.to, this.background, this.isAllDay});

  String courseCode;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
