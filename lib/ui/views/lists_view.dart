import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/ui_components/list_horizontal_builder.dart';
import 'package:spesa_app/ui_components/new_list.dart';
import 'package:spesa_app/ui_components/text_separator.dart';

class ListsView extends StatefulWidget {
  @override
  _ListsViewState createState() => _ListsViewState();
}

class _ListsViewState extends State<ListsView> {
  List<ListsModel> lists;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          TextSeparator(
            textMargin: 45.0,
            text: RichText(
              text: new TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: "Tasks",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  TextSpan(
                    text: " Lists",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          OutlinedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(50, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: () {
              _showModalBottomSheet(context);
            },
            child: Icon(
              Ionicons.add,
              color: Theme.of(context).buttonColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Add List",
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(height: 250.0, child: ListHorizontalBuilder()),
        ],
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return NewList();
    },
  );
}
