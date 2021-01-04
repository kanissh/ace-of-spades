/* import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ClassSchedulePage extends StatefulWidget {
  @override
  _ClassSchedulePageState createState() => _ClassSchedulePageState();
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 2)),
    isAllDay: true,
    subject: 'Meeting',
    color: Colors.blue,
    startTimeZone: '',
    endTimeZone: '',
  ));

  return DataSource(appointments);
}

class _ClassSchedulePageState extends State<ClassSchedulePage> {
  CalendarController _calendarController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCalendar(
          controller: _calendarController,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 6,
            endHour: 18,
          ),
          firstDayOfWeek: 1,
          view: _calendarController.view,
          dataSource: _getCalendarDataSource(),
        ),
      ),
    );
  }
}
 */
