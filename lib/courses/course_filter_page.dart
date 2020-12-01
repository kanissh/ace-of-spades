import 'package:flutter/material.dart';

class CourseFilterPage extends StatefulWidget {
  List<String> subjectFilters;
  List<String> levelFilters;
  List<String> creditFilters;

  CourseFilterPage(this.subjectFilters, this.levelFilters, this.creditFilters);

  @override
  _CourseFilterPageState createState() => _CourseFilterPageState();
}

class _CourseFilterPageState extends State<CourseFilterPage> {
  final String ch = 'Chemistry';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, [
            widget.subjectFilters,
            widget.levelFilters,
            widget.creditFilters,
          ]);

          return false;
        },
        child: Scaffold(
          body: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, [
                    widget.subjectFilters,
                    widget.levelFilters,
                    widget.creditFilters,
                  ]);
                },
                child: Text('OK'),
              ),
              FilterChip(
                  label: Text(ch),
                  selected: widget.subjectFilters.contains(ch),
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        widget.subjectFilters.add(ch);
                      } else {
                        widget.subjectFilters.isNotEmpty
                            ? widget.subjectFilters.remove(ch)
                            : print('');
                      }
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
