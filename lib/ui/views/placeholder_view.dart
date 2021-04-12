import 'package:flutter/cupertino.dart';

class PlaceholderView extends StatelessWidget {
  final Color color;

  PlaceholderView(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
