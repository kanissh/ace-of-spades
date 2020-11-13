import 'package:ace_of_spades/person/person.dart';
import 'package:ace_of_spades/person/person_details_tile.dart';
import 'package:ace_of_spades/person/person_info.dart';
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
        body: PersonInfo(person: person),
      ),
    );
  }
}
