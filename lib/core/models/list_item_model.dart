class ListItemModel {
  String id;
  String title;
  String cost;
  bool done;

  ListItemModel(this.title, this.cost, this.done);

  ListItemModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        title = snapshot['title'] ?? '',
        done = snapshot['done'] ?? '',
        cost = snapshot['cost'] ?? '';

  toJson() {
    return {"title": title, "done": done, "cost": cost};
  }
}
