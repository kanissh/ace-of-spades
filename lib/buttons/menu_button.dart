import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO: refactor styles to a constant seperately

class MenuButton extends StatelessWidget {
  static const Color menuIconColor = Color(0xFF9D170E);

  MenuButton({@required this.buttonIcon, @required this.buttonText});

  final IconData buttonIcon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
        // TODO: define constructor parameter for onPressed function
        onPressed: () {},
        child: SizedBox(
          height: 35,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: FaIcon(
                  buttonIcon,
                  color: menuIconColor,
                ),
              ),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
