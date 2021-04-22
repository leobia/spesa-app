import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/list_item_model.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';

class ListItemsWidget extends StatelessWidget {
  final ListsModel listDetail;
  final ListItemModel item;

  ListItemsWidget({@required this.listDetail, @required this.item});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ListItemRepository>(context);

    return Dismissible(
      key: Key(item.id),
      background: Container(
        color: Colors.red,
      ),
      resizeDuration: Duration(seconds: 1),
      onDismissed: (direction) async {
        await itemProvider.removeItem(listDetail.id, item.id);
      },
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(
              decoration:
                  item.done ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        subtitle: Text(
          item.description.isNotEmpty ? item.description : '',
          style: item.done
              ? TextStyle(
                  color: Theme.of(context).disabledColor,
                  decoration: TextDecoration.lineThrough)
              : TextStyle(),
        ),
        leading: Checkbox(
          value: item.done,
          fillColor: MaterialStateProperty.all(Theme.of(context).accentColor),
          onChanged: (bool value) {},
        ),
        onTap: () {
          var data = <String, dynamic>{};
          data.putIfAbsent('title', () => item.title);
          data.putIfAbsent('description', () => item.description);
          data.putIfAbsent('done', () => !item.done);
          itemProvider.updateDocument(listDetail.id, data, item.id);
        },
      ),
    );
  }
}
