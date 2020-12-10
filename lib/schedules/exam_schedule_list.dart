import 'package:ace_of_spades/schedules/exam_schedule_object.dart';
import 'package:ace_of_spades/schedules/exam_schedule_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamScheduleList extends StatelessWidget {
  final List pendingCourseList;
  ExamScheduleList({this.pendingCourseList});

  CollectionReference examScheduleRef = FirebaseFirestore.instance.collection('exam_schedule');

  List<String> getCourseCode(List list) {
    List<String> results = List();

    for (var item in list) {
      results.add(item['course_code'].toString().toUpperCase());
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return pendingCourseList == null || pendingCourseList.isEmpty
        ? Text('No examination soon')
        : StreamBuilder(
            stream: examScheduleRef.where('course_code', whereIn: getCourseCode(pendingCourseList)).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Data error occurred'); //TODO: handle
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('waiting'); //TODO: add waiting indicator
              }

              if (snapshot.connectionState == ConnectionState.active) {
                return ListView(
                  children: snapshot.data.documents.map<Widget>((DocumentSnapshot documentSnapshot) {
                    return ExamScheduleTile(
                      examScheduleObject: ExamScheduleObject.convertToObject(documentSnapshot: documentSnapshot),
                    );
                  }).toList(),
                );
              }

              return Text('Could not load data');
            },
          );
  }
}