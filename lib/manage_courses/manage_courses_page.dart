import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/add_courses_page.dart';
import 'package:ace_of_spades/manage_courses/manage_course_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ManageCoursesPage extends StatefulWidget {
  @override
  _ManageCoursesPageState createState() => _ManageCoursesPageState();
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  /* var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfig.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());
 */
  //TODO: Test above
  var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');

  getEnrolledCourses() {
    return StreamBuilder(
        stream: studentDocument.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          List<ManageCourseTileRemove> widgetList = List();
          if (snapshot.hasError) {
            return Text('Data error occurred'); //TODO: handle
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('waiting'); //TODO: add waiting indicator

          }

          if (snapshot.connectionState == ConnectionState.active) {
            List courseList = snapshot.data.data()['courses'];
            List enrolledCourseList = courseList.where((course) {
              return course['status'] == CourseStatus.ENROLLED;
            }).toList();

            enrolledCourseList.forEach((courseMap) {
              widgetList.add(
                ManageCourseTileRemove(
                  studentCourse: StudentCourse.convertToObject(courseMap),
                ),
              );
            });

            return ListView(children: widgetList);
          }

          return Text('Could not load data');
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddCoursePage()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Enrolled Courses'),
        ),
        body: getEnrolledCourses(),
      ),
    );
  }
}
