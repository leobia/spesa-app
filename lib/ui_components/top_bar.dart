import 'package:flutter/material.dart';

import 'new_list.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Container(
            child: Text(
              "Liste",
              style: TextStyle(
                fontFamily: 'Lora',
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                _showModalBottomSheet(context);
              },
              child: Text(
                "+ LISTA",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return NewList();
      },
    );
  }
}
