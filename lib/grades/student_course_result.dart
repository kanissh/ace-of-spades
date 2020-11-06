import 'package:flutter/material.dart';

class StudentCourseGrades extends StatelessWidget {
  Map<String, dynamic> studentDetails;
  List<Widget> _courseList = List();
  StudentCourseGrades({@required this.studentDetails});

  @override
  Widget build(BuildContext context) {
    Map _courses = studentDetails['courses'];

    for (dynamic sem in _courses.keys) {
      for (Map course in _courses[sem]) {
        _Course tempCourse = _Course(
            courseName: course['name'].toString(),
            courseCode: course['course_code'].toString().toUpperCase(),
            courseGrade: course['grade'].toString(),
            courseCredits: course['credits']);
        _courseList.add(tempCourse.createWidget());
      }
    }

    return Column(
      children: _courseList,
    );
  }
}

class _Course {
  String courseCode;
  String courseName;
  String courseGrade;
  int courseCredits;

  _Course(
      {@required this.courseName, @required this.courseCode, @required this.courseGrade, @required this.courseCredits});

  createWidget() {
    return SizedBox(
      // height: 35,
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      this.courseCode,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.green[900], borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        '${courseCredits.toString()} Credits',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                this.courseName,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Text(
            this.courseGrade,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
