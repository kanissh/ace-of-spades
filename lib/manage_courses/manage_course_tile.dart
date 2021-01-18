import 'package:ace_of_spades/constants/course_remarks.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/enrolment_service.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ManageCourseTileAdd extends StatefulWidget {
  final Course course;
  final bool isRegistrationOpenAdd;

  ManageCourseTileAdd({this.course, this.isRegistrationOpenAdd});

  @override
  _ManageCourseTileAddState createState() => _ManageCourseTileAddState();
}

class _ManageCourseTileAddState extends State<ManageCourseTileAdd> {
  String courseRemarks = 'proper';

  Future<List> _showDialogBox(BuildContext context, Course course) async {
    return showDialog<List>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enroll'),
          content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Select Enrolment Status'),
                  RadioListTile(
                    title: Text(
                      'Proper',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.PROPER,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Medical Proper',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.MEDICAL_PROPER,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Special',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.SPECIAL,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Repeat',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.REPEAT,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  Text('Confirm enrolment into ${course.code} ${course.name}')
                ],
              ),
            );
          }),
          actions: <Widget>[
            RaisedButton(
              child: Text('Cancel'),
              onPressed: () {
                print(courseRemarks);
                Navigator.of(context).pop([false, courseRemarks]);
              },
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              color: Colors.green,
              child: Text('Enrol'),
              onPressed: () {
                print(courseRemarks);
                Navigator.of(context).pop([true, courseRemarks]);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.course.code),
      subtitle: Text(widget.course.name),
      trailing: IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: widget.isRegistrationOpenAdd
            ? () async {
                List addParam = await _showDialogBox(context, widget.course);
                print(addParam);
                if (addParam[0]) {
                  EnrolmentService.addCourse(widget.course, addParam[1]);
                }
              }
            : null,
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
            SizedBox(
              width: 10,
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
