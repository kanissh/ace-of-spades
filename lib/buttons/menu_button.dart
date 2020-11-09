import 'package:ace_of_spades/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO: refactor styles to a constant seperately

class MenuButton extends StatelessWidget {
  MenuButton(
      {@required this.buttonIcon, @required this.buttonText, this.onTap});

  // TODO: make onTap required

  final IconData buttonIcon;
  final String buttonText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
        // TODO: try ListTile for buttons
        // TODO: define constructor parameter for onPressed function
        onPressed: () {
          onTap();
        },
        child: SizedBox(
          height: 35,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: FaIcon(
                  buttonIcon,
                  color: Constant.menuIconColor,
                ),
              ),
              Text(
                buttonText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
