import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseSearch extends SearchDelegate {
  final Future<QuerySnapshot> courseList;
  final List<String> subjectFilters;
  final List<String> levelFilters;
  final List<String> creditFilters;

  CourseSearch(
      {this.courseList,
      this.subjectFilters,
      this.levelFilters,
      this.creditFilters});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: courseList,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data!'),
          );
        }

        List<QueryDocumentSnapshot> results = snapshot.data.docs;

        if (subjectFilters.isNotEmpty) {
          results = results
              .where((c) => subjectFilters.contains(c['subject'].toString()))
              .toList();
        }

        if (levelFilters.isNotEmpty) {
          results = results
              .where((c) => levelFilters.contains(c['name'].split('')[1][0]))
              .toList();
        }

        if (creditFilters.isNotEmpty) {
          results = results
              .where((c) =>
                  subjectFilters.contains(c['credits']['2019'].toString()))
              .toList();
        }

        return ListView(
          children: results.map(
            (DocumentSnapshot documentSnapshot) {
              return ListTile(
                title: Text(documentSnapshot.data()['name']),
                onTap: () => query = documentSnapshot.data()['name'],
              );
            },
          ).toList(),
        );
      },
    );
  }
}
