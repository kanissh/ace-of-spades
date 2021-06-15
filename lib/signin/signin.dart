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
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  illustrationLoginDoor,
                  semanticsLabel: 'login illustration',
                  height: MediaQuery.of(context).size.height * 0.30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Login',
                  style: bodyText28Monred,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Login with your university G-suite account to continue...',
                  style: bodyText18,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  color: Colors.grey.shade300,
                  splashColor: Colors.grey.shade400,
                  onPressed: () async {
                    User _user = await signInWithGoogle();
                    if (_user != null) {
                      return ProfilePage(_user);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Falied to login'),
                            content: Text(
                                'Please ensure that you use a G-suite email to log in.\n\n \"sxxxxx@sci.pdn.ac.lk\" were sxxxxx is your registration number'),
                            actions: [
                              RaisedButton(
                                onPressed: () {},
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );

                      googleDisconnect();
                    }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}


/* SvgPicture.asset(
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
              ) */