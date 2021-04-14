import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/ui_components/list_item_builder.dart';
import 'package:spesa_app/ui_components/new_item.dart';
import 'package:spesa_app/ui_components/text_separator.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context, widget.listDetail);
        },
        child: Icon(Ionicons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 25, bottom: 20),
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Ionicons.close),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            TextSeparator(
              textMargin: 45.0,
              text: RichText(
                text: new TextSpan(
                  children: [
                    TextSpan(
                      text: this.widget.listDetail.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
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

void _showModalBottomSheet(BuildContext context, ListsModel listDetail) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return NewItem(listDetail: listDetail);
    },
  );
}
