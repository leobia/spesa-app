import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/itemListModel.dart';
import 'package:spesa_app/core/viewmodels/ItemListCRUDModel.dart';
import 'package:spesa_app/ui/widgets/ListItemRow.dart';

class ListBuilder extends StatefulWidget {
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<ItemList> lists;

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ItemListCRUDModel>(context);
    return StreamBuilder(
      stream: listProvider.fetchListsAsStream(),
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
    lists = snapshot.data.docs
        .map((doc) => ItemList.fromMap(doc.data(), doc.id))
        .toList();

    if (lists.isEmpty) {
      return Image(image: AssetImage('assets/new_item.png'));
    }

    return ListView.builder(
      itemCount: lists.length,
      itemBuilder: (context, index) => ListItemRow(listDetail: lists[index]),
    );
  }
}
