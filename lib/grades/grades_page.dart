import 'package:ace_of_spades/grades/student_course_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GradesPage extends StatefulWidget {
  static String id = '/gradesPage';

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
    String regNo = '001';
    return [regNo, path];
  }

  @override
  Widget build(BuildContext context) {
    List<String> documentInfo = getDocumentPath(_userEmail);
    CollectionReference students =
        FirebaseFirestore.instance.collection(documentInfo[1]);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: //FIXME: fix "CURRENT gpa" part, overflows
                            // Column(
                            //children: [
                            // Text(
                            //   'Current',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //   ),
                            // ),
                            Text(
                          'GPA',
                          style: TextStyle(fontSize: 53),
                        ), //TODO: Refactor textstyles
                        //],
                      ),
                    ),
                    //),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          '4.00',
                          style: TextStyle(fontSize: 53),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: FutureBuilder<DocumentSnapshot>(
                  future: students.doc(documentInfo[0]).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                      //TODO: Add error animation
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return StudentCourseGrades(studentDetails: data);
                    }

                    return Text('Loading'); //TODO: add loading animation
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
