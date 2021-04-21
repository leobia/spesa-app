import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/ui_components/dashboard_builder.dart';
import 'package:spesa_app/ui_components/new_list.dart';

class ListsView extends StatefulWidget {
  @override
  _ListsViewState createState() => _ListsViewState();
}

class _ListsViewState extends State<ListsView> {
  List<ListsModel> lists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showModalBottomSheet(context);
        },
        icon: Icon(Ionicons.add),
        label: Text("Add List"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            "Dashboard",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: DashboardBuilder(),
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
