import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/manage_course_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageCoursesPage extends StatefulWidget {
  @override
  _ManageCoursesPageState createState() => _ManageCoursesPageState();
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  CollectionReference _linkCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.CLASSROOM_LINK);
  CollectionReference _coursesCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.COURSE);
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
          }
          if (snapshot.connectionState == ConnectionState.active) {
            List courseList = snapshot.data.data()['courses'];
            List enrolledCourseList = courseList.where((course) {
              return course['status'] == CourseStatus.ENROLLED;
            }).toList();

            enrolledCourseList.forEach((courseMap) {
              print(courseMap);
              widgetList.add(
                ManageCourseTileRemove(
                  studentCourse: StudentCourse.convertToObject(courseMap),
                ),
              );
            });

            return ListView(children: widgetList);
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Manage Courses'),
        ),
        body: StreamBuilder(
          stream: _coursesCollectionReference.where('avail', isEqualTo: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Data error occurred'); //TODO: handle
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('waiting'); //TODO: add waiting indicator

            }

            if (snapshot.connectionState == ConnectionState.active) {
              // print(snapshot.data.toString());
              List<ManageCourseTileAdd> list =
                  snapshot.data.docs.map<ManageCourseTileAdd>((DocumentSnapshot documentSnapshot) {
                return ManageCourseTileAdd(course: Course.convertCourseDocToObject(documentSnapshot));
              }).toList();

              // return ListView(
              //   children: list,
              // );
              return getEnrolledCourses();
            }

            return Text('Could not load data');
          },
        ),
      ),
    );
  }
}
