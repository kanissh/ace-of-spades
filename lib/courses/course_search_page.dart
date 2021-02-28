import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/course_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'course_filter_page.dart';

class CourseSearchPage extends StatefulWidget {
  @override
  _CourseSearchPageState createState() => _CourseSearchPageState();
}

class _CourseSearchPageState extends State<CourseSearchPage> {
  CollectionReference courses = FirebaseFirestore.instance.collection(DbConfigPath.COURSE);

  List<String> subjectFilters = <String>[];
  List<String> levelFilters = <String>[];
  List<String> creditFilters = <String>[];

  _getFilterLists(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseFilterPage(subjectFilters, levelFilters, creditFilters),
      ),
    );
    setState(() {
      subjectFilters = result[0];
      levelFilters = result[1];
      creditFilters = result[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          onPressed: () {
            showSearch(
              context: context,
              delegate: CourseSearch(
                courseList: courses.get(),
                subjectFilters: subjectFilters,
                levelFilters: levelFilters,
                creditFilters: creditFilters,
              ),
            );
          },
          child: Icon(Icons.search),
        ),
        appBar: AppBar(
          title: Text('Course Search'),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list_alt),
              onPressed: () {
                _getFilterLists(context);
              },
            ),
          ],
          centerTitle: true,
        ),
        body: Container(),
      ),
    );
  }
}

/*
Course c = new Course(
    code: "ST 306",
    name: "Data analysis & Preparation of Reports",
    subject: "Statistics",
    credits: {"2019": 1, "2020": 1},
    desc:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
    generalComp: false,
    specialComp: true,
    prereq: ["st302", "st301"],
    refBooks: [],
    typeTheory: true,
    avail: false,
    tags: []);
*/
