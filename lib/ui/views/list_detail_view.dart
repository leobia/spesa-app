import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:menu_button/menu_button.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/core/utils/color-utils.dart';
import 'package:spesa_app/core/utils/globals.dart';
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
        color: colorsMap[status]["backgroundColor"],
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            color: darken(colorsMap[status]["textColor"], 0.25),
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
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 25, bottom: 20),
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Ionicons.close),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MenuButton(
                  child: normalChildButton,
                  items: statusList,
                  toggledChild: normalChildButton,
                  onItemSelected: (e) async {
                    print(e);
                    setState(() {
                      status = e;
                    });
                    Map<String, dynamic> data = {"status": statusValueMap[e]};
                    await listProvider.updateDocument(
                        data, widget.listDetail.id);
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
                ),
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
