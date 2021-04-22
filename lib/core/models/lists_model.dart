import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spesa_app/core/models/list_item_model.dart';

class ListsModel {
  String id;
  String description;
  Timestamp date;
  List<String> members;
  String title;
  List<ListItemModel> items;
  String status;

  ListsModel(this.id, this.description, this.date, this.members, this.title,
      this.status);

  ListsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        description = snapshot['description'] ?? '',
        date = snapshot['date'] ?? '',
        title = snapshot['title'] ?? '',
        members = snapshot['members'].cast<String>() ?? '',
        status = snapshot['status'] ?? '';

  Map<String, Object> toJson() {
    return {
      'description': description,
      'date': date,
      'members': members,
      'title': title,
      'status': status
    };
  }
}
