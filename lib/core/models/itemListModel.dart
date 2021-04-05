import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList {
  String id;
  String budget;
  Timestamp date;
  List<String> items;
  List<String> members;
  String title;

  ItemList(
      this.id, this.budget, this.date, this.items, this.members, this.title);

  ItemList.fromMap(Map snapshot, String id)
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
