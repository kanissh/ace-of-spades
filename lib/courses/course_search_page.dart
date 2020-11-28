import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/courses/course_card.dart';
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
        body: CourseTile(c),
      ),
    );
  }
}

// ST306,{"code":"ST 306","name":"Data analysis & Preparation of Reports","subject" : "Statistics","credits": {"2019" : 1,"2020" : 1},"desc" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat","general_comp" : false,"special_comp" : true,"prereq": ["st302","st301"],"ref_books" : [],"type_theory" : true,"avail":false,"tags":[]}