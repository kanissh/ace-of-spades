import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnrolmentService {
  CollectionReference _linkCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.CLASSROOM_LINK);

  static addCourse(String courseCode) {}

  static removeCourse(StudentCourse studentCourse) {
/* var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfig.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());
 */
    //TODO: Test above

    var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');
    studentDocument.update({
      'courses': FieldValue.arrayRemove([studentCourse.getMap()])
    });
  }
}
