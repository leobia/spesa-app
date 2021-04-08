import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/list_item_model.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';
import 'package:spesa_app/ui/widgets/list_items_widget.dart';

class ListItemBuilder extends StatefulWidget {
  final ListsModel listDetail;

  ListItemBuilder({Key key, @required this.listDetail}) : super(key: key);

  @override
  _ListItemBuilderState createState() => _ListItemBuilderState();
}

class _ListItemBuilderState extends State<ListItemBuilder> {
  List<ListItemModel> items;

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListItemRepository>(context);
    return StreamBuilder(
      stream: listProvider.fetchItemsAsStream(this.widget.listDetail.id),
      builder: listBuilder,
    );
  }

  Widget listBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    items = snapshot.data.docs
        .map((doc) => ListItemModel.fromMap(doc.data(), doc.id))
        .toList();

    if (items.isEmpty) {
      return Image(image: AssetImage('assets/new_item.png'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ListItemsWidget(
        listDetail: this.widget.listDetail,
        item: items[index],
      ),
    );
  }
}
