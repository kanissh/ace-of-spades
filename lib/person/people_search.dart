import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeopleSearch extends SearchDelegate {
  CollectionReference people = FirebaseFirestore.instance.collection('people');

  List<String> listExample;
  List<String> recentList = [];
  String selectedResult;

  PeopleSearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(listExample.where(
            (element) => element.contains(query),
          ));
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              suggestionList[index],
            ),
            onTap: () {
              selectedResult = suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}
