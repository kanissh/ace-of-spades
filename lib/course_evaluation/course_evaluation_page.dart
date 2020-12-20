import 'package:ace_of_spades/course_evaluation/evaluation_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseEvaluationPage extends StatefulWidget {
  @override
  _CourseEvaluationPageState createState() => _CourseEvaluationPageState();
}

class _CourseEvaluationPageState extends State<CourseEvaluationPage> {
  /* var doc = FirebaseFirestore.instance
      .collection('students/s16/s16stu')
      .doc(FirebaseAuth.instance.currentUser.email.substring(0, 3));
 */

  var studentDocument = FirebaseFirestore.instance.collection('students/s16/s16stu').doc('002');

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
        appBar: AppBar(),
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
                return e['grade'].toString().contains('pending');
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

/* SingleChildScrollView(
          child: Expanded(
            child: Html(
              data:
                  '<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSfEayGDAdIRgmFhFumHxkq8MBl3Qk8_yWK1kmELOHnTjYm6Bg/viewform?embedded=true" width=${MediaQuery.of(context).size.width} height=${MediaQuery.of(context).size.height} frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>',
            ),
          ),
        ), */
