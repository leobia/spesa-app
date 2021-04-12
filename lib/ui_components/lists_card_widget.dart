import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/list_item_model.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';
import 'package:spesa_app/ui/views/list_detail_view.dart';

class ListsCardWidget extends StatefulWidget {
  final ListsModel listDetail;
  final LinearGradient color;

  ListsCardWidget({@required this.listDetail, @required this.color});

  @override
  _ListsCardWidgetState createState() => _ListsCardWidgetState();
}

class _ListsCardWidgetState extends State<ListsCardWidget> {
  List<ListItemModel> items;

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListItemRepository>(context);

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ListDetailView(listDetail: widget.listDetail),
              ));
        },
        child: GradientCard(
          gradient: widget.color,
          shadowColor: widget.color.colors.last.withOpacity(0.3),
          elevation: 10,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          child: Container(
            width: 160.0,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.listDetail.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: StreamBuilder(
                        stream: listProvider
                            .fetchItemsAsStream(widget.listDetail.id),
                        builder: itemBuilder,
                      ),
                    ),
                  ),
                ],
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

    return ListView.builder(
      itemCount: min(items.length, 4),
      itemBuilder: (context, index) => RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            WidgetSpan(
              child: items[index].done
                  ? Icon(
                      Ionicons.checkmark_outline,
                      color: Colors.white,
                    )
                  : Icon(
                      Ionicons.square_outline,
                      color: Colors.white,
                    ),
            ),
            TextSpan(
              text: items[index].title,
              style: TextStyle(
                color: Colors.white,
                decoration: items[index].done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
