import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolmentService {
  CollectionReference _linkCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.CLASSROOM_LINK);

  static addCourse(Course course) {
    /* var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfig.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());
 */
    //TODO: Test above

    var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');
    StudentCourse studentCourse = StudentCourse(
        code: course.code,
        name: course.name,
        credits: course.credits[course.credits.firstKey()],
        grade: 'pending',
        semester: '', //TODO: semester and year needed variable from db
        year: '',
        courseDocRef: FirebaseFirestore.instance.collection(DbConfigPath.COURSE).doc(course.code.replaceAll(' ', '')),
        status: CourseStatus.ENROLLED);
    studentDocument.update({
      'courses': FieldValue.arrayUnion([studentCourse.getMap()])
    });
  }

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
