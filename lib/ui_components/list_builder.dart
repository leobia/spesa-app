import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/net/list_repository.dart';

class ListsBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: listBuilder,
      future: getCurrentUserLists(),
    );
  }

  Widget listBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      children: snapshot.data.docs
          .map(
            (document) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text("${document.data()['title']}"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
              resizeDuration: Duration(seconds: 1),
              onDismissed: (direction) async {
                // Remove the item from the data source.
                await removeList(document.id);
                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${document.data()['title']} dismissed")));
              },
            ),
          )
          .toList(),
    );
  }
}
