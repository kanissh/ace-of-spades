import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InheritedPerson extends InheritedWidget {
  InheritedPerson({Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
