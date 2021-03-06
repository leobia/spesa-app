import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/ui/views/list_detail_view.dart';

class ListsWidget extends StatelessWidget {
  final ListsModel listDetail;

  ListsWidget({@required this.listDetail});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListsRepository>(context);

    return Dismissible(
      key: Key(listDetail.id),
      background: Container(
        color: Colors.red,
      ),
      resizeDuration: Duration(seconds: 1),
      onDismissed: (direction) async {
        await listProvider.removeList(listDetail.id);
      },
      child: ListTile(
        title: Text(listDetail.title),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListDetailView(listDetail: listDetail),
            ),
          );
        },
      ),
    );
  }
}
