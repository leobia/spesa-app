import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';

import 'lists_card_widget.dart';

class ListHorizontalBuilder extends StatefulWidget {
  @override
  _ListHorizontalBuilderState createState() => _ListHorizontalBuilderState();
}

class _ListHorizontalBuilderState extends State<ListHorizontalBuilder> {
  List<ListsModel> lists;
  final List<LinearGradient> cardColors = [
    LinearGradient(
      colors: [
        Color.fromRGBO(140, 229, 245, 1.0),
        Color.fromRGBO(56, 176, 218, 1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromRGBO(254, 146, 178, 1.0),
        Color.fromRGBO(192, 64, 102, 1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromRGBO(184, 158, 255, 1.0),
        Color.fromRGBO(111, 92, 196, 1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromRGBO(254, 211, 162, 1.0),
        Color.fromRGBO(254, 166, 60, 1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromRGBO(168, 149, 240, 1.0),
        Color.fromRGBO(140, 116, 248, 1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ),
  ];

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
      scrollDirection: Axis.horizontal,
      itemCount: lists.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) => ListsCardWidget(
        listDetail: lists[index],
        color: getColor(index),
      ),
    );
  }

  LinearGradient getColor(int index) {
    var i = index;
    if (i >= cardColors.length) {
      i = cardColors.length % i;
    }
    return cardColors[i];
  }
}
