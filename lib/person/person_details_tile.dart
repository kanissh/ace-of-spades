import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
