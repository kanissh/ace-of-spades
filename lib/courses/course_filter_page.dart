import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/filter_data.dart';
import 'package:ace_of_spades/ui_components/subheading_red.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubHeadingRed(
                  title: 'department',
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    buildFilterChip(FilterData.bl, widget.subjectFilters),
                    buildFilterChip(FilterData.bt, widget.subjectFilters),
                    buildFilterChip(FilterData.zl, widget.subjectFilters),
                    buildFilterChip(FilterData.gl, widget.subjectFilters),
                    buildFilterChip(FilterData.ch, widget.subjectFilters),
                    buildFilterChip(FilterData.cs, widget.subjectFilters),
                    buildFilterChip(FilterData.mb, widget.subjectFilters),
                    buildFilterChip(FilterData.st, widget.subjectFilters),
                    buildFilterChip(FilterData.en, widget.subjectFilters),
                    buildFilterChip(FilterData.mt, widget.subjectFilters),
                    buildFilterChip(FilterData.ec, widget.subjectFilters),
                    buildFilterChip(FilterData.mgt, widget.subjectFilters),
                  ],
                ),
                blockDivider,
                Wrap(
                  spacing: 10,
                  children: [
                    buildFilterChip(FilterData.level100, widget.levelFilters),
                    buildFilterChip(FilterData.level200, widget.levelFilters),
                    buildFilterChip(FilterData.level300, widget.levelFilters),
                    buildFilterChip(FilterData.level400, widget.levelFilters),
                  ],
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    buildFilterChip(FilterData.credit1, widget.creditFilters),
                    buildFilterChip(FilterData.credit2, widget.creditFilters),
                    buildFilterChip(FilterData.credit3, widget.creditFilters),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FilterChip buildFilterChip(String chipName, List<String> filterList) {
    return FilterChip(
        checkmarkColor: redColor,
        label: Text(chipName),
        selected: filterList.contains(chipName),
        onSelected: (bool value) {
          setState(() {
            if (value) {
              filterList.add(chipName);
            } else {
              filterList.isNotEmpty ? filterList.remove(chipName) : print('');
            }
          });
        });
  }
}
