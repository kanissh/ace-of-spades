import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/person/people_search.dart';
import 'package:ace_of_spades/person/person_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  CollectionReference people = FirebaseFirestore.instance.collection('people');

  bool chemistry, physics, botany, statcs, zoology, geology = true;
  List<String> selectedDept = ['Chemistry', 'Physics'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: PeopleSearch());
              },
            )
          ],
          centerTitle: true,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: people.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Error detected');
              //TODO: Fix above error handling
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Waiting');
            }

            if (snapshot == null) {
              print('null snapshot');
            }

            return ListView(
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return PersonCard(
                  name: documentSnapshot.data()['name'],
                  position: documentSnapshot.data()['position'],
                  department: documentSnapshot.data()['department'],
                  personDocument: documentSnapshot.data(),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

//FIXME: give an null snapshot error shows in terminal fix it
