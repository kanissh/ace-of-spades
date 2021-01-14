import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:flutter/material.dart';

class ManageCourseTileAdd extends StatelessWidget {
  final Course course;

  ManageCourseTileAdd({this.course});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.code),
      subtitle: Text(course.name),
      trailing: IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () {},
      ),
    );
  }
}

class ManageCourseTileRemove extends StatelessWidget {
  final StudentCourse studentCourse;

  ManageCourseTileRemove({this.studentCourse});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(studentCourse.code),
      subtitle: Text(studentCourse.name),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: () {},
      ),
    );
  }
}
