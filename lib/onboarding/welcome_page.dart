import 'package:ace_of_spades/onboarding/manage_onb_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class WelcomePage extends StatelessWidget {
  final titleText = 'Welcome';

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
                Text(
                  'Welcome to the Student Mobile Application of Faculty of Science, University of Peradeniya.',
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
                  color: redColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageOnBoardPage()));
                  },
                  child: SizedBox(
                    width: 200,
                    height: 40,
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: buttonTextW,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
