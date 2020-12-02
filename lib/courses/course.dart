import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Course {
  String code;
  String name;
  String subject;
  String desc;
  bool avail = false;
  Map credits;
  bool generalComp = false; //general_comp
  bool specialComp = false; //special_comp
  bool typeTheory; //type_theory
  List prereq;
  List refBooks; //ref_books
  List tags;

  Course(
      {@required this.code,
      @required this.name,
      @required this.subject,
      this.desc,
      this.avail,
      @required this.credits,
      this.generalComp,
      this.specialComp,
      this.typeTheory,
      this.prereq,
      this.refBooks,
      this.tags});

  @override
  String toString() {
    return 'Course{code: $code, name: $name, subject: $subject, desc: $desc, avail: $avail, credits: $credits, generalComp: $generalComp, specialComp: $specialComp, typeTheory: $typeTheory, prereq: $prereq, refBooks: $refBooks, tags: $tags}';
  }

  static Course convertCourseDocToObject(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> courseMap = documentSnapshot.data();
    return Course(
        code: courseMap['code'],
        name: courseMap['name'],
        desc: courseMap['desc'],
        avail: courseMap['avail'],
        credits: courseMap['credits'],
        generalComp: courseMap['general_comp'],
        specialComp: courseMap['special_comp'],
        typeTheory: courseMap['type_theory'],
        prereq: courseMap['prereq'] as List,
        refBooks: courseMap['ref_books'],
        tags: courseMap['tags']);
  }
}
