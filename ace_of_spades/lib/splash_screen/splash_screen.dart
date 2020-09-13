import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FractionallySizedBox(
        //box to prevent bleeding when window is resized
        widthFactor: 2,
        alignment: Alignment.center,
        child: Row(
          //row to align crest and text
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image(
                image: AssetImage('images/crest.png'),
                height: 90,
                width: 90,
              ),
            ),
            Column(
              //column to place the texts
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Faculty of Science',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                  ),
                ),
                Text(
                  'University of Peradeniya',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
