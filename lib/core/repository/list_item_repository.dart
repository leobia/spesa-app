import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/core/models/list_item_model.dart';

//https://medium.com/flutter-community/flutter-firebase-realtime-database-crud-operations-using-provider-c242a01f6a10
class ListItemRepository extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  ListItemRepository() {
    ref = _db.collection('lists');
  }

  List<ListItemModel> itemItem;

  Future<List<ListItemModel>> fetchItems(String listId) async {
    var result = await getItemsOrderBy(listId, 'date');
    itemItem = result.docs
        .map((doc) => ListItemModel.fromMap(doc.data(), doc.id))
        .toList();
    return itemItem;
  }

  Stream<QuerySnapshot> fetchItemsAsStream(String listId) {
    return streamItemsOrderBy(listId, 'done');
  }

  Future removeItem(String listId, String id) async {
    await removeDocument(listId, id);
    return;
  }

  Future addItem(String listId, String title, bool done, String cost) async {
    Map<String, dynamic> data = new Map();
    data.putIfAbsent('title', () => title);
    data.putIfAbsent('cost', () => cost);
    data.putIfAbsent('done', () => done);

    await addDocument(listId, data);
  }

  Future<QuerySnapshot> getItemsOrderBy(String listId, String orderBy) {
    return ref
        .doc(listId)
        .collection('items')
        .orderBy(orderBy, descending: true)
        .get();
  }

  Stream<QuerySnapshot> streamItemsOrderBy(String listId, String orderBy) {
    return ref
        .doc(listId)
        .collection('items')
        .orderBy(orderBy, descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String listId, String id) {
    return ref.doc(listId).collection('items').doc(id).get();
  }

  Future<void> removeDocument(String listId, String id) {
    return ref.doc(listId).collection('items').doc(id).delete();
  }

  Future<DocumentReference> addDocument(String listId, Map data) {
    return ref.doc(listId).collection('items').add(data);
  }

  Future<void> updateDocument(String listId, Map data, String id) {
    return ref.doc(listId).collection('items').doc(id).update(data);
  }
}
