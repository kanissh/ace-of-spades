import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/grades.dart';
import 'package:ace_of_spades/schedules/exam_schedule_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamScheduleState createState() => _ExamScheduleState();
}

class _ExamScheduleState extends State<ExamSchedulePage> {
  CollectionReference examScheduleRef = FirebaseFirestore.instance.collection(DbConfigPath.EXAM_SCHEDULE);
  /* var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfig.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());
 */
  //TODO: Test above
  var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Exam Schedule',
          ),
        ),
        body: FutureBuilder(
          future: studentDocument.get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Data error occurred'); //TODO: handle
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('waiting'); //TODO: add waiting indicator
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              List courseList = data['courses'];

              // get courses where result is pending
              List courseListPending = courseList.where((e) {
                return e['grade'].toString().contains(Grades.O);
              }).toList();

              return ExamScheduleList(
                pendingCourseList: courseListPending, //courseListPending,
              );
            }
            return Text('Could not load data');
          },
        ),
      ),
    );
  }
}
