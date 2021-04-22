import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/list_item_model.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/core/utils/double-utils.dart';
import 'package:spesa_app/ui/views/list_detail_view.dart';

class ListsCardWidget extends StatefulWidget {
  final ListsModel listDetail;

  ListsCardWidget({@required this.listDetail});

  @override
  _ListsCardWidgetState createState() => _ListsCardWidgetState();
}

class _ListsCardWidgetState extends State<ListsCardWidget> {
  List<ListItemModel> items;

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListsRepository>(context);
    final itemProvider = Provider.of<ListItemRepository>(context);

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onLongPress: () async {
          if (await confirm(
            context,
            title: Text('Confirm'),
            content: Text('Would you like to remove?'),
            textOK: Text('Yes'),
            textCancel: Text('No'),
          )) {
            await itemProvider.removeAllItems(widget.listDetail.id);
            await listProvider.removeList(widget.listDetail.id);
            return print('pressedOK');
          }
          return print('pressedCancel');
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ListDetailView(listDetail: widget.listDetail),
            ),
          );
        },
        child: Card(
          borderOnForeground: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              width: 1.3,
              color: Theme.of(context).shadowColor,
            ),
          ),
          child: ListTile(
            minVerticalPadding: 35.0,
            title: Text(
              widget.listDetail.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              widget.listDetail.description,
              style: TextStyle(fontSize: 12.0),
            ),
            trailing: Container(
              width: 50,
              child: StreamBuilder(
                stream: itemProvider.fetchItemsAsStream(widget.listDetail.id),
                builder: itemBuilder,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    items = snapshot.data.docs
        .map((doc) => ListItemModel.fromMap(doc.data(), doc.id))
        .toList();
    var percentage = 0.0;

    if (items != null && items.isNotEmpty) {
      percentage = roundDouble(
          items.where((element) => element.done).length / items.length, 1);
    }
    return CircularPercentIndicator(
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
    );
  }
}
