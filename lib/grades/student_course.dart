import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCourse {
  final String code;
  final String name;
  final int credits;
  final String grade;
  final String semester;
  final String year;
  final DocumentReference courseDocRef;
  final String status;

  StudentCourse(
      {this.code, this.name, this.credits, this.grade, this.semester, this.year, this.courseDocRef, this.status});

  static StudentCourse convertToObject(Map<String, dynamic> courseMap) {
    return StudentCourse(
        code: courseMap['course_code'],
        name: courseMap['name'],
        credits: courseMap['credits'],
        grade: courseMap['grade'],
        semester: courseMap['sem'],
        year: courseMap['year'],
        courseDocRef: courseMap['course_doc'],
        status: courseMap['status']);
  }
}
