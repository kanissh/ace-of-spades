import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/constants/illustration_names.dart';
import 'package:ace_of_spades/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatelessWidget {
  static String id = '/signIn';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi,',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 72,
                  color: redColor,
                ),
              ),
              Text(
                'Welcome to FOS mobile',
                style: bodyText18,
              ),
              SvgPicture.asset(
                illustrationLoginDoor,
                semanticsLabel: 'login illustration',
                height: MediaQuery.of(context).size.height * 0.30,
              ),
              Text(
                'Login with your university G-suite account to continue...',
                style: bodyText18,
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                elevation: 10,
                color: Colors.grey.shade300,
                splashColor: Colors.grey.shade400,
                onPressed: () async {
                  User _user = await signInWithGoogle();
                  return ProfilePage(_user);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Image(
                        image: AssetImage('images/google_logo.png'),
                        width: 25,
                      ),
                    ),
                    Text(
                      'Sign in with Google',
                      style: bodyText18,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
