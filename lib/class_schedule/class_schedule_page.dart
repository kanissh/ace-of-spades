import 'package:ace_of_spades/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'course_schedule.dart';
import 'schedule_data_source.dart';

class ClassSchedulePage extends StatefulWidget {
  @override
  _ClassSchedulePageState createState() => _ClassSchedulePageState();
}

class _ClassSchedulePageState extends State<ClassSchedulePage> {
  CalendarController _calendarController;
  List<CourseSchedule> courseScheduleList = <CourseSchedule>[];

  CollectionReference classScheduleRef = FirebaseFirestore.instance.collection('class_schedule');
  /* var doc = FirebaseFirestore.instance
      .collection('students/s16/s16stu')
      .doc(FirebaseAuth.instance.currentUser.email.substring(0, 3));
 */
  //TODO: set this

  var studentDocument = FirebaseFirestore.instance.collection('students/s16/s16stu').doc('002');

  @override
  void initState() {
    _calendarController = CalendarController();
    _calendarController.view = CalendarView.day;
    super.initState();
  }

  List<String> getCourseCode(List list) {
    List<String> results = List();

    for (var item in list) {
      results.add(item['course_code'].toString().toUpperCase());
    }

    return results;
  }

  ScheduleDataSource _getCalendarDataSource(
      List<Map<String, dynamic>> scheduleDocMap, List<CourseSchedule> courseSchList) {
    if (scheduleDocMap != null || scheduleDocMap.isNotEmpty) {
      for (var schDoc in scheduleDocMap) {
        courseSchList.add(
          CourseSchedule.createCourseSchedule(
            scheduleDocument: schDoc,
            backgroundColor: Colors.greenAccent[400],
          ),
        );
      }
    }

    return ScheduleDataSource(courseScheduleList);
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      _calendarController.view = CalendarView.day;
    } else if (details.targetElement == CalendarElement.appointment) {
      if (_calendarController.view == CalendarView.week) {
        _calendarController.view = CalendarView.day;
      }
      //TODO: complete or remove action
    } else if (details.targetElement == CalendarElement.viewHeader) {
      //TODO: complete or remove action
      showInfoDialog(title: 'title', content: 'con');
    }
  }

  void showInfoDialog({String title, String content}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: redColor),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ac_unit),
          onPressed: () {
            if (_calendarController.view == CalendarView.day) {
              _calendarController.view = CalendarView.week;
            } else {
              _calendarController.view = CalendarView.day;
            }
          },
        ),
        body: FutureBuilder(
          future: studentDocument.get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

              return StreamBuilder(
                stream: classScheduleRef.where('course_code', whereIn: getCourseCode(courseListPending)).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Data error occurred'); //TODO: handle
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('waiting');
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    List<Map<String, dynamic>> list = List();
                    print('active');
                    snapshot.data.docs.map((e) {
                      list.add(e.data());
                    }).toList();

                    return SfCalendar(
                      todayHighlightColor: redColor,
                      todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      controller: _calendarController,
                      firstDayOfWeek: 1,
                      timeSlotViewSettings: TimeSlotViewSettings(startHour: 6, endHour: 19),
                      dataSource: _getCalendarDataSource(list, courseScheduleList),
                      onTap: (CalendarTapDetails details) {
                        calendarTapped(details);
                      },
                    );
                  }
                  return Text('Could not load data');
                },
              );
            }
            return Text('Could not load data');
          },
        ),
      ),
    );
  }
}
