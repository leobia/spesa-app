import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Widget rightButton;
  final Widget leftButton;

  TopBar({@required this.title, this.leftButton, this.rightButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: [
          Container(
            child: leftButton,
          ),
          Container(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Lora',
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ),
          Container(
            child: rightButton,
          ),
        ],
      ),
    );
  }
}
