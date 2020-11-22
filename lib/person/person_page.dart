import 'package:ace_of_spades/person/person_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  CollectionReference people = FirebaseFirestore.instance.collection('people');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: people.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Error detected');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Waiting');
            }

            return ListView(
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return PersonCard(
                  name: documentSnapshot.data()['name'].toString(),
                  position: documentSnapshot.data()['position'].toString(),
                  department: documentSnapshot.data()['department'].toString(),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
