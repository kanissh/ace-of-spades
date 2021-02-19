import 'package:flutter/material.dart';

import '../constants.dart';

class OnBoardingNextButton extends StatelessWidget {
  OnBoardingNextButton({this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: redColor,
      onPressed: () {
        onTap();
      },
      child: SizedBox(
        width: 200,
        height: 40,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Next',
                style: buttonTextW,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
