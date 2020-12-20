import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EvaluationList extends StatelessWidget {
  final List pendingCourseList;
  EvaluationList({this.pendingCourseList});

  CollectionReference evalRef = FirebaseFirestore.instance.collection('course_evaluations');

  List<String> getCourseCode(List list) {
    List<String> results = List();

    for (var item in list) {
      results.add(item['course_code'].toString().toUpperCase());
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: evalRef.where('course_code', whereIn: getCourseCode(pendingCourseList)).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load'),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Evaluations posted!!'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            List<Widget> wid = List();

            wid = snapshot.data.docs.map<Widget>((DocumentSnapshot documentSnapshot) {
              return Text(documentSnapshot.data()['course_code'].toString());
            }).toList();

            return ListView(children: wid);
          }

          return Center(
            child: Text('Unexpected error occurred'),
          );
        });
  }
}
