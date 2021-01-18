import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/enrolment_status.dart';
import 'package:ace_of_spades/constants/grades.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolmentService {
  CollectionReference _linkCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.CLASSROOM_LINK);

  static addCourse(Course course) async {
    String remarks = 'repeat';
    /* var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfig.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());
 */
    //TODO: Test above

    var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');
    var courseList =
        await studentDocument.get().then((DocumentSnapshot documentSnapshot) => documentSnapshot['courses']);

    if (remarks == EnrolmentStatus.PROPER) {
      if (courseList.any((element) => element['course_code'].toString().toUpperCase() == course.code.toUpperCase())) {
        print('ERROR');
      } else {
        print('course added prop'); //add course;
      }
    } else if (remarks == EnrolmentStatus.MEDICAL_PROPER || remarks == EnrolmentStatus.SPECIAL) {
      if (courseList.any((element) {
        return element['course_code'].toString().toUpperCase() == course.code.toUpperCase() &&
            (element['grade'] == Grades.O || element['grade'] == Grades.I);
      })) {
        print('course added'); //add course;
      } else {
        print('ERROR');
      }
    } else {
      if (courseList.any((element) {
        return element['course_code'].toString().toUpperCase() == course.code.toUpperCase() &&
            (element['grade'] == Grades.C_MINUS ||
                element['grade'] == Grades.D ||
                element['grade'] == Grades.D_PLUS ||
                element['grade'] == Grades.E);
      })) {
        print('course added'); //add course;
      } else {
        print('ERROR');
      }
    }

    /* StudentCourse studentCourse = StudentCourse(
        code: course.code,
        name: course.name,
        credits: course.credits[course.credits.firstKey()],
        grade: 'pending',
        semester: '', //TODO: semester and year needed variable from db
        year: '',
        courseDocRef: FirebaseFirestore.instance
            .collection(DbConfigPath.COURSE)
            .doc(course.code.replaceAll(' ', '')), //FIXME: document names differ
        status: CourseStatus.ENROLLED);
    studentDocument.update({
      'courses': FieldValue.arrayUnion([studentCourse.getMap()])
    }); */
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
