import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/core/utils/globals.dart';
import 'package:spesa_app/ui_components/custom_pie_chart.dart';

import 'lists_card_widget.dart';

class DashboardBuilder extends StatefulWidget {
  @override
  _DashboardBuilderState createState() => _DashboardBuilderState();
}

class _DashboardBuilderState extends State<DashboardBuilder> {
  List<ListsModel> lists = [];
  List<ListsModel> listsByStatus = [];
  String statusSelected = 'Todo';

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

    listsByStatus = lists
        .where((element) => element.status == statusValueMap[statusSelected])
        .toList();

    return ListView(
      shrinkWrap: true,
      children: [
        CustomPieChart(lists: lists),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Divider(
            height: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Lists',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ChoiceChip(
                  selected: statusSelected == 'Todo',
                  label: Text(
                    'Todo',
                    style: statusSelected == 'Todo'
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: TODO_COLOR,
                  onSelected: (_) {
                    setState(() {
                      statusSelected = 'Todo';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ChoiceChip(
                  selected: statusSelected == 'Pending',
                  label: Text(
                    'Pending',
                    style: statusSelected == 'Pending'
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: PENDING_COLOR,
                  onSelected: (_) {
                    setState(() {
                      statusSelected = 'Pending';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ChoiceChip(
                  selected: statusSelected == 'Done',
                  label: Text(
                    'Done',
                    style: statusSelected == 'Done'
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: DONE_COLOR,
                  onSelected: (_) {
                    setState(() {
                      statusSelected = 'Done';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: listsByStatus.length,
          itemBuilder: (context, index) =>
              ListsCardWidget(listDetail: listsByStatus[index]),
        ),
      ],
    );
  }
}
