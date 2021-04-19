import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/ui_components/custom_pie_chart.dart';

import 'lists_card_widget.dart';

class DashboardBuilder extends StatefulWidget {
  @override
  _DashboardBuilderState createState() => _DashboardBuilderState();
}

class _DashboardBuilderState extends State<DashboardBuilder> {
  List<ListsModel> lists = [];

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListsRepository>(context);
    return StreamBuilder(
      stream: listProvider.fetchListsAsStream(),
      builder: dashboardBuilder,
    );
  }

  Widget dashboardBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    lists = snapshot.data.docs
        .map((doc) => ListsModel.fromMap(doc.data(), doc.id))
        .toList();

    return ListView(
      shrinkWrap: true,
      children: [
        CustomPieChart(lists: lists),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: lists.length,
          itemBuilder: (context, index) =>
              ListsCardWidget(listDetail: lists[index]),
        ),
      ],
    );
  }
}
