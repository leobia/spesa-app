import 'package:cloud_firestore/cloud_firestore.dart';

class ListsModel {
  String id;
  String budget;
  Timestamp date;
  List<String> items;
  List<String> members;
  String title;

  ListsModel(
      this.id, this.budget, this.date, this.items, this.members, this.title);

  ListsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        budget = snapshot['price'] ?? '',
        date = snapshot['date'] ?? '',
        title = snapshot['title'] ?? '',
        items = snapshot['items'].cast<String>() ?? '',
        members = snapshot['members'].cast<String>() ?? '';

  toJson() {
    return {
      "budget": budget,
      "date": date,
      "items": items,
      "members": members,
      "title": title
    };
  }
}
