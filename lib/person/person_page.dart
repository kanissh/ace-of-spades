import 'package:ace_of_spades/person/person.dart';
import 'package:ace_of_spades/person/person_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonPage extends StatelessWidget {
  Person person = Person(
      name: 'John Adams',
      designation: 'Professor',
      academicCred: 'PhD',
      email: 'johnadams@email.com',
      phone: '0000000000',
      mobile: '0000000000',
      department: 'Department of Statistics and Computer Science');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      minRadius: 40,
                      maxRadius: 55,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            person.name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            person.academicCred,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.userTie,
              content: person.designation,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.building,
              content: person.department,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.solidEnvelope,
              content: person.email,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.phoneAlt,
              content: person.phone,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.mobileAlt,
              content: person.mobile,
            ),
          ],
        ),
      ),
    );
  }
}
