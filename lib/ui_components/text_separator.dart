import 'package:flutter/material.dart';

class TextSeparator extends StatelessWidget {
  final double textMargin;
  final Widget text;
  final double externalMargin;

  TextSeparator({
    Key key,
    this.textMargin = 30.0,
    this.text = const Text("OR"),
    this.externalMargin = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: new Container(
          margin: EdgeInsets.only(
            left: externalMargin,
            right: textMargin,
          ),
          child: Divider(
            color: Colors.grey,
            height: 36,
            thickness: 0.80,
          ),
        ),
      ),
      text,
      Expanded(
        child: new Container(
          margin: EdgeInsets.only(
            left: textMargin,
            right: externalMargin,
          ),
          child: Divider(
            color: Colors.grey,
            height: 36,
            thickness: 0.80,
          ),
        ),
      ),
    ]);
  }
}
