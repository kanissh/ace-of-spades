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

  var studentDocument = FirebaseFirestore.instance.collection('students/s16/s16stu').doc('002');

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
        courseSchList.add(CourseSchedule(
            courseCode: schDoc['course_code'],
            from: schDoc['start_time'].toDate(),
            to: schDoc['end_time'].toDate(),
            isAllDay: false,
            background: Colors.blue[400],
            recurrenceRule: schDoc['recur']
                ? 'FREQ=WEEKLY;INTERVAL=1;BYDAY=${schDoc['weekday']};UNTIL=${schDoc['recur_until']}'
                : null));
      }
    }

    return ScheduleDataSource(courseScheduleList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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

                    print(list);
                    print(list.length);
                    return SfCalendar(
                      view: CalendarView.day,
                      firstDayOfWeek: 1,
                      timeSlotViewSettings: TimeSlotViewSettings(startHour: 6, endHour: 19),
                      dataSource: _getCalendarDataSource(list, courseScheduleList),
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
