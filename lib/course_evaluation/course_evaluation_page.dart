import 'package:ace_of_spades/constants/grades.dart';
import 'package:ace_of_spades/course_evaluation/evaluation_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseEvaluationPage extends StatefulWidget {
  @override
  _CourseEvaluationPageState createState() => _CourseEvaluationPageState();
}

class _CourseEvaluationPageState extends State<CourseEvaluationPage> {
  /* var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfig.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());
 */

  var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');

  _launchUrl(String _url) async {
    final url = _url;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        enableJavaScript: true,
      );
    } else {
      throw 'Error $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Evaluation'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: studentDocument.get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Failed to load'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              List courseList = data['courses'];

              // get courses where result is pending
              List courseListPending = courseList.where((e) {
                return e['grade'].toString().contains(Grades.O);
              }).toList();

              return EvaluationList(
                pendingCourseList: courseListPending,
              );
            }

            return Center(
              child: Text('Unexpected error occurred'),
            );
          },
        ),
      ),
    );
  }
}
