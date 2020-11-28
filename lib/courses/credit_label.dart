import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';

import 'course.dart';

class CreditLabel extends StatelessWidget {
  final Course course;

  CreditLabel({this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: creditsLabelColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          course.credits[DateTime.now().year.toString()].toString() +
              ' Credits',
          style: creditsLabelText,
        ),
      ),
    );
  }
}
