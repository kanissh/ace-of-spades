import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';
import 'course.dart';

class CourseTile extends StatelessWidget {
  Course course;

  CourseTile(this.course);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  course.code,
                  style: bodyText18b,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: creditsLabelColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      course.credits[DateTime.now().year.toString()]
                              .toString() +
                          ' Credits',
                      style: creditsLabelText,
                    ),
                  ),
                )
              ],
            ),
            Text(
              course.name,
              style: subtitle18i,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              course.desc,
              style: subtitle14,
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: add enrol button
