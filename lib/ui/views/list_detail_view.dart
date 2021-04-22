import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/core/utils/color-utils.dart';
import 'package:spesa_app/core/utils/globals.dart';
import 'package:spesa_app/ui_components/list_item_builder.dart';
import 'package:spesa_app/ui_components/new_item.dart';

class ListDetailView extends StatefulWidget {
  final ListsModel listDetail;

  ListDetailView({Key key, @required this.listDetail}) : super(key: key);

  @override
  _ListDetailViewState createState() => _ListDetailViewState();
}

class _ListDetailViewState extends State<ListDetailView> {
  String status = '';

  @override
  void initState() {
    super.initState();
    status = statusMap[widget.listDetail.status];
  }

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListsRepository>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context, widget.listDetail);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Ionicons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: PopupMenuButton(
              onSelected: (e) async {
                print(e);
                setState(() {
                  status = e;
                });
                var data = <String, dynamic>{'status': statusValueMap[e]};
                await listProvider.updateDocument(data, widget.listDetail.id);
              },
              itemBuilder: (context) => statuses
                  .map((e) =>
                      PopupMenuItem(value: e['label'], child: Text(e['label'])))
                  .toList(),
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  color: statusColorMap[status]['backgroundColor'],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                    child: Text(
                  status,
                  style: TextStyle(
                    color: statusColorMap[status]['textColor'],
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 25, bottom: 20),
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                widget.listDetail.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              widget.listDetail.description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: darken(Theme.of(context).disabledColor, 0.2),
              ),
            ),
            Expanded(
              child: ListItemBuilder(listDetail: widget.listDetail),
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
