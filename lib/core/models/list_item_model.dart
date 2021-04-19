class ListItemModel {
  String id;
  String title;
  String description;
  bool done;

  ListItemModel(this.title, this.description, this.done);

  ListItemModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        title = snapshot['title'] ?? '',
        done = snapshot['done'] ?? '',
        description = snapshot['description'] ?? '';

  toJson() {
    return {"title": title, "done": done, "description": description};
  }
}
