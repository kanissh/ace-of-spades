import 'package:ace_of_spades/grades/calculate_gpa.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/grades/student_course_tile.dart';
import 'package:ace_of_spades/ui_components/subheading_red.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final String _userEmail = FirebaseAuth.instance.currentUser.email;

  getDocumentPath(String email) {
    String level = email.substring(0, 3);
    // String regNo = email.substring(3, 6);
    //String path = 'students/${level}/${level}stu';

    // FIXME: set the above to normal for using with uni email
    String path = 'students/s16/s16stu';
    String regNo = '002';
    return [regNo, path];
  }

  void addToWidgetList(List dataList, List<Widget> widgetList) {
    for (var item in dataList) {
      widgetList.add(
        StudentCourseTile(
          studentCourse: StudentCourse.convertToObject(item),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> documentInfo = getDocumentPath(_userEmail);

    Future<DocumentSnapshot> studentDocument =
        FirebaseFirestore.instance.collection(documentInfo[1]).doc(documentInfo[0]).get();

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: studentDocument,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Cannot load connection'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading'),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              List courseList = data['courses'];

              // get courses where result is pending
              List courseListPending = courseList.where((e) {
                return e['grade'].toString().contains('pending');
              }).toList();

              // get completed courses
              List courseListCompleted = courseList.where((e) {
                return !e['grade'].toString().contains('pending');
              }).toList();

              //create new widget list to display
              List<Widget> _courseTileList = List();

              //add initial heading
              _courseTileList.addAll([
                blockDivider,
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SubHeadingRed(title: 'on going courses'),
                ),
                SizedBox(
                  height: 5,
                )
              ]);

              //add pending courses
              addToWidgetList(courseListPending, _courseTileList);

              //add completed heading
              _courseTileList.addAll([
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SubHeadingRed(title: 'completed courses'),
                ),
                SizedBox(
                  height: 5,
                )
              ]);

              //add completed list
              addToWidgetList(courseListCompleted, _courseTileList);

              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CurrentGPA(),
                        Text(
                          CalculateGpa.calculateGpa(courseList: courseListCompleted).toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 53,
                            color: redColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView(
                      children: _courseTileList,
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text('Could not load data'),
            );
          },
        ),
      ),
    );
  }
  /* @override
  Widget build(BuildContext context) {
    List<String> documentInfo = getDocumentPath(_userEmail);

    Future<DocumentSnapshot> studentDocument =
        FirebaseFirestore.instance.collection(documentInfo[1]).doc(documentInfo[0]).get();

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CurrentGPA(),
                FutureBuilder(
                  future: studentDocument,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Connection not found');
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      List courseList = data['courses'];

                      List courseListCompleted = courseList.where((e) {
                        return !e['grade'].toString().contains('pending');
                      }).toList();

                      return Text(
                        CalculateGpa.calculateGpa(courseList: courseListCompleted).toStringAsFixed(2),
                        style: TextStyle(fontSize: 53),
                        textAlign: TextAlign.right,
                      );
                    }

                    return Text('loading');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: FutureBuilder<DocumentSnapshot>(
              future: studentDocument,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  List courseList = data['courses'];

                  // get courses where result is pending
                  List courseListPending = courseList.where((e) {
                    return e['grade'].toString().contains('pending');
                  }).toList();

                  // get completed courses
                  List courseListCompleted = courseList.where((e) {
                    return !e['grade'].toString().contains('pending');
                  }).toList();

                  //create new widget list to display
                  List<Widget> _courseTileList = List();

                  //add initial heading
                  _courseTileList.addAll([
                    blockDivider,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SubHeadingRed(title: 'on going courses'),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ]);

                  //add pending courses
                  addToWidgetList(courseListPending, _courseTileList);

                  //add completed heading
                  _courseTileList.addAll([
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SubHeadingRed(title: 'completed courses'),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ]);

                  //add completed list
                  addToWidgetList(courseListCompleted, _courseTileList);

                  return ListView(
                    children: _courseTileList,
                  );
                }

                return Text("loading");
              },
            ),
          ),
        ],
      ),
    ));
  } */
}

class CurrentGPA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current',
            style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
          ),
          Text(
            'GPA',
            style: TextStyle(fontSize: 32, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
