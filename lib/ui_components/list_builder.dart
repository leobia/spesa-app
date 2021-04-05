import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/ui/widgets/lists_widget.dart';

class ListBuilder extends StatefulWidget {
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<ListsModel> lists;

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListsRepository>(context);
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
        .map((doc) => ListsModel.fromMap(doc.data(), doc.id))
        .toList();

    if (lists.isEmpty) {
      return Image(image: AssetImage('assets/new_item.png'));
    }

    return ListView.builder(
      itemCount: lists.length,
      itemBuilder: (context, index) => ListsWidget(listDetail: lists[index]),
    );
  }
}
