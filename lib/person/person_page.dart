import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/person/people_search.dart';
import 'package:ace_of_spades/person/person_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  CollectionReference people = FirebaseFirestore.instance.collection(DbConfigPath.PEOPLE);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Find People'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: PeopleSearch(people.get()));
              },
            )
          ],
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: people.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Error detected');
              //TODO: Fix above error handling
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Waiting');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  return PersonCard(
                    name: documentSnapshot.data()['name'],
                    position: documentSnapshot.data()['position'],
                    department: documentSnapshot.data()['department'],
                    personDocument: documentSnapshot.data(),
                  );
                }).toList(),
              );
            }

            return Text('Something went wrong');
          },
        ),
      ),
    );
  }
}
