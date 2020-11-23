import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/person/person.dart';
import 'package:ace_of_spades/person/person_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String position;
  final String department;
  final DocumentSnapshot documentSnapshot;

  PersonCard(
      {@required this.name,
      @required this.position,
      @required this.department,
      this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Person _person = Person(
            name: documentSnapshot.data()['name'],
            position: documentSnapshot.data()['position'],
            department: documentSnapshot.data()['department']);

        print('Tapped');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonProfile(person: _person)));
      },
      child: Container(
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
      ),
    );
  }
}
