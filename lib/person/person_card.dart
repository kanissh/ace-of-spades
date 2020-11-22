import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String position;
  final String department;

  PersonCard(
      {@required this.name,
      @required this.position,
      @required this.department});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: borderColor, width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              position,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              department,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
