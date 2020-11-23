import 'package:ace_of_spades/person/person.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonProfile extends StatelessWidget {
  const PersonProfile({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: CircleAvatar(
                minRadius: 40,
                maxRadius: 55,
              ),
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
                  /*Text(
                    person.academicCred,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.userTie,
              content: person.position,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.building,
              content: person.department,
            ),
            /*PersonDetailsTile(
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
            ),*/
          ],
        ),
      ),
    );
  }
}

class PersonDetailsTile extends StatelessWidget {
  final IconData icon;
  final String content;

  PersonDetailsTile({@required this.icon, @required this.content});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(this.icon),
      title: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
