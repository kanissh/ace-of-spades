import 'package:ace_of_spades/schedules/exam_schedule_list.dart';
import 'package:ace_of_spades/schedules/exam_schedule_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamScheduleState createState() => _ExamScheduleState();
}

class _ExamScheduleState extends State<ExamSchedulePage> {
  CollectionReference examScheduleRef = FirebaseFirestore.instance.collection('exam_schedule');
  /* var doc = FirebaseFirestore.instance
      .collection('students/s16/s16stu')
      .doc(FirebaseAuth.instance.currentUser.email.substring(0, 3));
 */

  var studentDocument = FirebaseFirestore.instance.collection('students/s16/s16stu').doc('002');

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
          builder: (context, snapshot) {
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
                return e['grade'].toString().contains('pending');
              }).toList();

              return ExamScheduleList(
                pendingCourseList: List(), //courseListPending,
              );
            }
            return Text('Could not load data');
          },
        ),
      ),
    );
  }
}
