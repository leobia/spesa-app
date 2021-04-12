import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spesa_app/core/models/list_item_model.dart';

class ListsModel {
  String id;
  String budget;
  Timestamp date;
  List<String> members;
  String title;
  List<ListItemModel> items;

  ListsModel(this.id, this.budget, this.date, this.members, this.title);

  ListsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        budget = snapshot['price'] ?? '',
        date = snapshot['date'] ?? '',
        title = snapshot['title'] ?? '',
        members = snapshot['members'].cast<String>() ?? '';

  toJson() {
    return {"budget": budget, "date": date, "members": members, "title": title};
  }
}
