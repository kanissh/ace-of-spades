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

  ScheduleDataSource _getCalendarDataSource() {
    courseScheduleList.add(CourseSchedule(
      from: DateTime.now().subtract(Duration(hours: 5)),
      to: DateTime.now().add(Duration(hours: 1)),
      isAllDay: false,
      courseCode: 'Meeting',
      background: Colors.red,
    ));

    courseScheduleList.add(CourseSchedule(
      from: DateTime.now().subtract(Duration(hours: 5)),
      to: DateTime.now().add(Duration(hours: 1)),
      isAllDay: false,
      courseCode: 'Meeting',
      background: Colors.red,
    ));

    return ScheduleDataSource(courseScheduleList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCalendar(
          controller: _calendarController,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 6,
            endHour: 19,
          ),
          firstDayOfWeek: 1,
          view: CalendarView.day,
          dataSource: _getCalendarDataSource(),
        ),
      ),
    );
  }
}
