import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/courses/course_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseSearchPage extends StatefulWidget {
  @override
  _CourseSearchPageState createState() => _CourseSearchPageState();
}

class _CourseSearchPageState extends State<CourseSearchPage> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          onPressed: () {},
          child: Icon(Icons.filter_list_alt),
        ),
        appBar: AppBar(
          title: Text('Course Search'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: CourseSearch());
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
