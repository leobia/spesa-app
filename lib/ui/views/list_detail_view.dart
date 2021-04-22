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
  String status = "";

  @override
  void initState() {
    super.initState();
    status = statusMap[widget.listDetail.status];
  }

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListsRepository>(context);

    final Widget normalChildButton = Container(
      width: 85,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 0,
          style: BorderStyle.none,
          color: Colors.transparent,
        ),
        color: statusColorMap[status]["backgroundColor"],
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            color: darken(statusColorMap[status]["textColor"], 0.25),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context, widget.listDetail);
        },
        child: Icon(Ionicons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.close),
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
                Map<String, dynamic> data = {"status": statusValueMap[e]};
                await listProvider.updateDocument(data, widget.listDetail.id);
              },
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                    color: statusColorMap[status]["backgroundColor"],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                    child: Text(
                  status,
                  style: TextStyle(
                      color: statusColorMap[status]["textColor"],
                      fontWeight: FontWeight.bold),
                )),
              ),
              itemBuilder: (context) => statuses
                  .map((e) =>
                      PopupMenuItem(value: e["label"], child: Text(e["label"])))
                  .toList(),
            ),

            /*MenuButton(
              child: normalChildButton,
              items: statusList,
              toggledChild: normalChildButton,
              onItemSelected: (e) async {
                setState(() {
                  status = e;
                });
                Map<String, dynamic> data = {"status": statusValueMap[e]};
                await listProvider.updateDocument(data, widget.listDetail.id);
              },
              itemBuilder: (String value) => Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 16,
                ),
                child: Text(value),
              ),
            ),*/
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
                this.widget.listDetail.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              this.widget.listDetail.description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: darken(Theme.of(context).disabledColor, 0.2),
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
