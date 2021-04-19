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
    var result = await getItemsOrderBy(listId, 'done', false);
    itemItem = result.docs
        .map((doc) => ListItemModel.fromMap(doc.data(), doc.id))
        .toList();
    return itemItem;
  }

  Stream<QuerySnapshot> fetchItemsAsStream(String listId) {
    return streamItems(listId);
  }

  Future removeItem(String listId, String id) async {
    await removeDocument(listId, id);
    return;
  }

  Future removeAllItems(String listId) async {
    await removeDocuments(listId);
    return;
  }

  Future addItem(
      String listId, String title, bool done, String description) async {
    Map<String, dynamic> data = new Map();
    data.putIfAbsent('title', () => title);
    data.putIfAbsent('description', () => description);
    data.putIfAbsent('done', () => done);

    await addDocument(listId, data);
  }

  Future<QuerySnapshot> getItemsOrderBy(
      String listId, String orderBy, bool descending) {
    return ref
        .doc(listId)
        .collection('items')
        .orderBy(orderBy, descending: descending)
        .get();
  }

  Stream<QuerySnapshot> streamItemsOrderBy(
      String listId, String orderBy, bool descending) {
    return ref
        .doc(listId)
        .collection('items')
        .orderBy(orderBy, descending: descending)
        .snapshots();
  }

  Future<QuerySnapshot> getItems(String listId) {
    return ref.doc(listId).collection('items').get();
  }

  Stream<QuerySnapshot> streamItems(String listId) {
    return ref.doc(listId).collection('items').snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String listId, String id) {
    return ref.doc(listId).collection('items').doc(id).get();
  }

  Future<void> removeDocument(String listId, String id) {
    return ref.doc(listId).collection('items').doc(id).delete();
  }

  Future<void> removeDocuments(String listId) {
    ref.doc(listId).collection('items').get().then((snapshot) => {
          for (var doc in snapshot.docs) {doc.reference.delete()}
        });
    return null;
  }

  Future<DocumentReference> addDocument(String listId, Map data) {
    return ref.doc(listId).collection('items').add(data);
  }

  Future<void> updateDocument(String listId, Map data, String id) {
    return ref.doc(listId).collection('items').doc(id).update(data);
  }
}
