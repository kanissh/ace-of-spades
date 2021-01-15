import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/enrolment_service.dart';
import 'package:flutter/material.dart';

class ManageCourseTileAdd extends StatelessWidget {
  final Course course;
  final bool isRegistrationOpen;

  ManageCourseTileAdd({this.course, this.isRegistrationOpen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.code),
      subtitle: Text(course.name),
      trailing: IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: isRegistrationOpen ? EnrolmentService.addCourse(course.code) : null,
      ),
    );
  }
}

class ManageCourseTileRemove extends StatelessWidget {
  final StudentCourse studentCourse;
  final bool isRegistrationOpen;

  ManageCourseTileRemove({this.studentCourse, this.isRegistrationOpen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        studentCourse.code,
      ),
      subtitle: Text(studentCourse.name),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: isRegistrationOpen ? EnrolmentService.removeCourse(studentCourse.code) : null,
      ),
    );
  }
}
