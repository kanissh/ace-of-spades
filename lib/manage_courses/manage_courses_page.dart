import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
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
  DocumentReference configRegistrationDocument =
      FirebaseFirestore.instance.collection(DbConfigPath.CONFIG).doc(DbConfigPath.COURSE_REGISTRATION_CONFIG_DOC);

  bool isRegistrationOpenRemove = false;
  bool isRegistrationOpenAdd = false; //FIXME: default value, and is set dynamically

  void initState() {
    super.initState();
    setConfigParams();
  }

  getEnrolledCourses() {
    return StreamBuilder(
        stream: studentDocument.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          List<ManageCourseTileRemove> widgetList = [];
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
                  isRegistrationOpenRemove: isRegistrationOpenRemove,
                ),
              );
            });

            return widgetList.isEmpty
                ? Center(
                    child: Text(
                      'You have no enrolled courses to review!',
                      style: bodyText18,
                    ),
                  )
                : ListView(children: widgetList);
          }

          return Text('Could not load data');
        });
  }

  void setConfigParams() async {
    bool add = await configRegistrationDocument.get().then((value) => value.data()['registration_add']);
    bool remove = await configRegistrationDocument.get().then((value) => value.data()['registration_remove']);

    setState(() {
      isRegistrationOpenAdd = add;
      isRegistrationOpenRemove = remove;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Visibility(
          visible: (isRegistrationOpenAdd && !isRegistrationOpenRemove) ||
              (!isRegistrationOpenAdd && !isRegistrationOpenRemove),
          child: BottomSheet(
            elevation: 5,
            builder: (context) => Container(
              color: Colors.black87,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (isRegistrationOpenAdd && !isRegistrationOpenRemove)
                    ? Text(
                        'Oops! you cannot remove courses but course enrollment is open...', //TODO: clip below floation action button
                        style: TextStyle(color: Colors.white))
                    : Text('Course Registration is CLOSED!', style: TextStyle(color: Colors.white)),
              ),
            ),
            onClosing: () {},
          ),
        ),
        floatingActionButton: Visibility(
          visible: isRegistrationOpenAdd,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
            onPressed: isRegistrationOpenAdd
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCoursePage(
                          isRegistrationOpenAdd: isRegistrationOpenAdd,
                        ),
                      ),
                    );
                  }
                : null,
          ),
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
