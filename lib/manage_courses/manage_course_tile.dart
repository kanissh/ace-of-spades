import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/enrolment_service.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ManageCourseTileAdd extends StatelessWidget {
  final Course course;
  final bool isRegistrationOpenAdd;

  ManageCourseTileAdd({this.course, this.isRegistrationOpenAdd});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.code),
      subtitle: Text(course.name),
      trailing: IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: isRegistrationOpenAdd ? EnrolmentService.addCourse(course) : null,
      ),
    );
  }
}

class ManageCourseTileRemove extends StatelessWidget {
  final StudentCourse studentCourse;
  final bool isRegistrationOpenRemove;

  ManageCourseTileRemove({this.studentCourse, this.isRegistrationOpenRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        studentCourse.code,
      ),
      subtitle: Text(studentCourse.name),
      trailing: IconButton(
        color: redColor,
        icon: Icon(Icons.remove_circle),
        onPressed: isRegistrationOpenRemove
            ? () async {
                bool delete = await _showDialogBox(context, studentCourse);
                print(delete);
                if (delete) {
                  EnrolmentService.removeCourse(studentCourse);
                }
              }
            : null,
      ),
    );
  }

  Future<bool> _showDialogBox(BuildContext context, StudentCourse studentCourse) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unenroll'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to unenroll from ${studentCourse.code.toUpperCase()} - ${studentCourse.name}?'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text('Remove'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
