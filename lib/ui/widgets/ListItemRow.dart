import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/itemListModel.dart';
import 'package:spesa_app/core/viewmodels/ItemListCRUDModel.dart';

class ListItemRow extends StatelessWidget {
  final ItemList listDetail;

  ListItemRow({@required this.listDetail});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ItemListCRUDModel>(context);

    return Dismissible(
      key: Key(listDetail.id),
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text(listDetail.title),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {},
      ),
      resizeDuration: Duration(seconds: 1),
      onDismissed: (direction) async {
        await listProvider.removeList(listDetail.id);
      },
    );
  }
}
