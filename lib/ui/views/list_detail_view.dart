import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/ui_components/list_item_builder.dart';
import 'package:spesa_app/ui_components/new_list.dart';
import 'package:spesa_app/ui_components/top_bar.dart';

class ListDetailView extends StatefulWidget {
  final ListsModel listDetail;

  ListDetailView({Key key, @required this.listDetail}) : super(key: key);

  @override
  _ListDetailViewState createState() => _ListDetailViewState();
}

class _ListDetailViewState extends State<ListDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 10.0),
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 30.0),
            TopBar(
              title: this.widget.listDetail.title,
              leftButton: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left),
                color: Theme.of(context).accentColor,
              ),
              rightButton: IconButton(
                onPressed: () {
                  _showModalBottomSheet(context);
                },
                icon: Icon(Icons.add),
                color: Theme.of(context).accentColor,
              ),
            ),
            Expanded(
              child: ListItemBuilder(listDetail: this.widget.listDetail),
            )
          ],
        ),
      ),
    );
  }
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
