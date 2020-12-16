import 'package:ace_of_spades/signin/signin_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/classroom/v1.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:flutter/material.dart';

class ManageCoursesPage extends StatefulWidget {
  @override
  _ManageCoursesPageState createState() => _ManageCoursesPageState();
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  getAuthHeaders() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final authHeaders = googleSignInAccount.authHeaders;

    print(authHeaders);
  }

  @override
  Widget build(BuildContext context) {
    getAuthHeaders();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Manage Courses'),
        ),
        body: Container(),
      ),
    );
  }
}
