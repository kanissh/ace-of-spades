import 'package:ace_of_spades/schedules/exam_schedule_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'exam_schedule_tile.dart';

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamScheduleState createState() => _ExamScheduleState();
}

class _ExamScheduleState extends State<ExamSchedulePage> {
  CollectionReference examSchedule = FirebaseFirestore.instance.collection('exam_schedule');

  ExamScheduleObject examSchObject = ExamScheduleObject(
      courseCode: 'CS 999',
      startTime: DateTime(2020, 9, 27, 8, 30),
      endTime: DateTime(2020, 9, 7, 10, 30),
      desc: 'End Semester Examination');

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
        body: ExamScheduleTile(examScheduleObject: examSchObject),
      ),
    );
  }
}
