import 'package:flutter/material.dart';
import 'package:ace_of_spades/constants.dart';

class FilterCheckBoxListTile extends StatefulWidget {
  bool value;
  String tileTitle;
  List<String> list;

  FilterCheckBoxListTile({this.value, this.tileTitle, this.list});

  @override
  _FilterCheckBoxListTileState createState() => _FilterCheckBoxListTileState();
}

class _FilterCheckBoxListTileState extends State<FilterCheckBoxListTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.tileTitle,
        style: bodyText18,
      ),
      value: widget.value,
      onChanged: (bool val) {
        setState(() {
          widget.value = val;

          if (widget.list != null) {
            if (widget.value == true) {
              if (!widget.list.contains(widget.tileTitle.toLowerCase()))
                widget.list.add(widget.tileTitle.toLowerCase());
            } else {
              if (widget.list.contains(widget.tileTitle.toLowerCase()))
                widget.list.remove(widget.tileTitle.toLowerCase());
            }
          } else {
            if (widget.value == true) {
              widget.list.add(widget.tileTitle.toLowerCase());
            }
          }
        });

        print(widget.list.toString());
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
