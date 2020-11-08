import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentCourseGrades extends StatefulWidget {
  Map<String, dynamic> studentDetails;

  StudentCourseGrades({@required this.studentDetails});

  @override
  _StudentCourseGradesState createState() => _StudentCourseGradesState();
}

class _StudentCourseGradesState extends State<StudentCourseGrades> {
  List<Widget> _courseList = List();

  @override
  Widget build(BuildContext context) {
    Map _courses = widget.studentDetails['courses'];

    for (dynamic sem in _courses.keys) {
      _courseList.add(createSemester(sem));
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

  Widget createSemester(String semester) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
              child: Text(
                semester,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          /*Expanded(
            flex: 1,
            child: TextButton(
              child: Text('Unmark All'),
            ),
          ),*/
        ],
      ),
    );
  }
}

class _Course {
  String courseCode;
  String courseName;
  String courseGrade;
  int courseCredits;

  _Course(
      {@required this.courseName,
      @required this.courseCode,
      @required this.courseGrade,
      @required this.courseCredits});

  createWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            //FIXME:  fix border overlap
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        decoration: BoxDecoration(
                          color: Colors.green[900],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
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
            ),
            Expanded(
              flex: 1,
              child: Text(
                this.courseGrade, //FIXME: fix pending grade display
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
