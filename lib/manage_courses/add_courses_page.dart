import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'manage_course_tile.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  CollectionReference _linkCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.CLASSROOM_LINK);
  CollectionReference _coursesCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.COURSE);

  getAvailableCourses() {
    return StreamBuilder(
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

          return ListView(
            children: list,
          );
        }

        return Text('Could not load data');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Courses'),
          centerTitle: true,
        ),
        body: getAvailableCourses(),
      ),
    );
  }
}
