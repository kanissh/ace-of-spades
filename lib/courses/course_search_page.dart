import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/courses/course_card.dart';
import 'package:ace_of_spades/courses/course_details_page.dart';
import 'package:ace_of_spades/courses/course_search.dart';
import 'package:ace_of_spades/ui_components/subheading_red.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseSearchPage extends StatefulWidget {
  bool ch = true;
  bool bl = true;
  bool zl = true;
  bool bt = true;
  bool gl = true;
  bool cs = true;
  bool mb = true;
  bool st = true;
  bool en = true;
  bool mt = true;
  bool ec = true;
  bool mgt = true;
  bool l100 = true;
  bool l200 = true;
  bool l300 = true;
  bool l400 = true;
  bool cr1 = true;
  bool cr2 = true;
  bool cr3 = true;
  bool crVariable = true;

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
                      ),
                      FilterCheckBoxListTile(
                        value: widget.cs,
                        tileTitle: 'Computer Science',
                      ),
                      FilterCheckBoxListTile(
                        value: widget.st,
                        tileTitle: 'Statistics',
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

class FilterCheckBoxListTile extends StatefulWidget {
  bool value;
  String tileTitle;

  FilterCheckBoxListTile({this.value, this.tileTitle});

  @override
  _FilterCheckBoxListTileState createState() => _FilterCheckBoxListTileState();
}

class _FilterCheckBoxListTileState extends State<FilterCheckBoxListTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.tileTitle,
        style: bodyText18,
      ),
      value: widget.value,
      onChanged: (bool val) {
        setState(() {
          widget.value = val;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

// ST306,{"code":"ST 306","name":"Data analysis & Preparation of Reports","subject" : "Statistics","credits": {"2019" : 1,"2020" : 1},"desc" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat","general_comp" : false,"special_comp" : true,"prereq": ["st302","st301"],"ref_books" : [],"type_theory" : true,"avail":false,"tags":[]}
