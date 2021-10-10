import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/list_item_model.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';
import 'package:spesa_app/core/utils/double-utils.dart';
import 'package:spesa_app/core/utils/globals.dart';
import 'package:spesa_app/ui/widgets/list_items_widget.dart';

class ListItemBuilder extends StatefulWidget {
  final ListsModel listDetail;

  ListItemBuilder({Key key, @required this.listDetail}) : super(key: key);

  @override
  _ListItemBuilderState createState() => _ListItemBuilderState();
}

class _ListItemBuilderState extends State<ListItemBuilder> {
  List<ListItemModel> items = [];
  String sort = "title";

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListItemRepository>(context);
    return StreamBuilder(
      stream:
          listProvider.streamItemsOrderBy(widget.listDetail.id, sort, false),
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

    var percentage = 0.0;

    if (items != null && items.isNotEmpty) {
      percentage = roundDouble(
          items.where((element) => element.done).length / items.length, 1);
    }

    return Column(
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  DropdownButton<String>(
                    value: sort,

                    icon: const Icon(Ionicons.chevron_down_outline),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        sort = newValue;
                      });
                    },
                    items: <String>['title', 'description', 'done']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.capitalize()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 55.0,
                lineWidth: 6.0,
                animation: true,
                percent: percentage,
                center: Text(
                  '${(percentage * 100).round()}%',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.deepOrange,
              )
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) => ListItemsWidget(
              listDetail: widget.listDetail,
              item: items[index],
            ),
          ),
        )
      ],
    );
  }
}

