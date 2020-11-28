import 'package:flutter/cupertino.dart';

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
  List<String> prereq;
  List<String> refBooks; //ref_books
  List<String> tags;

  @override
  String toString() {
    return 'Course{code: $code, name: $name, subject: $subject, desc: $desc, avail: $avail, credits: $credits, generalComp: $generalComp, specialComp: $specialComp, typeTheory: $typeTheory, prereq: $prereq, refBooks: $refBooks, tags: $tags}';
  }

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
}
