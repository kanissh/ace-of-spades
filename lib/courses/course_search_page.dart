import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/courses/course_card.dart';
import 'package:ace_of_spades/courses/course_details_page.dart';
import 'package:ace_of_spades/courses/course_search.dart';
import 'package:ace_of_spades/ui_components/subheading_red.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'filter_check_box_list_tile.dart';

class CourseSearchPage extends StatefulWidget {
  bool ch = false;
  bool bl = false;
  bool zl = false;
  bool bt = false;
  bool gl = false;
  bool cs = false;
  bool mb = false;
  bool st = false;
  bool en = false;
  bool mt = false;
  bool ec = false;
  bool mgt = false;
  bool l100 = false;
  bool l200 = false;
  bool l300 = false;
  bool l400 = false;
  bool cr1 = false;
  bool cr2 = false;
  bool cr3 = false;
  bool crVariable = false;

  List<String> subject = <String>[];
  List<String> level = <String>[];
  List<String> credit = <String>[];

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

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SafeArea(
            child: Container(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SubHeadingRed(
                        title: 'subject',
                      ),
                      FilterCheckBoxListTile(
                        value: widget.ch,
                        tileTitle: 'Chemistry',
                        list: widget.subject,
                      ),
                      FilterCheckBoxListTile(
                        value: widget.cs,
                        tileTitle: 'Computer Science',
                        list: widget.subject,
                      ),
                      FilterCheckBoxListTile(
                        value: widget.st,
                        tileTitle: 'Statistics',
                        list: widget.subject,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          );
        });
      },
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          onPressed: () {
            displayBottomSheet(context);
          },
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
