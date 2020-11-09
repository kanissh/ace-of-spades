import 'package:flutter/material.dart';

class Person {
  String name;
  String designation;
  String academicCred;
  String email;
  // List<String> email;
  String mobile;
  String phone;
  String department; //FIXME: consider an enum value

  Person(
      {@required this.name,
      @required this.designation,
      this.academicCred,
      @required this.email,
      this.phone,
      this.mobile,
      @required this.department});
}
