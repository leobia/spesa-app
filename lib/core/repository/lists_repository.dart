import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/core/models/lists_model.dart';

//https://medium.com/flutter-community/flutter-firebase-realtime-database-crud-operations-using-provider-c242a01f6a10
class ListsRepository extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;
  List<ListsModel> itemList;

  ListsRepository() {
    ref = _db.collection('lists');
  }

  Future<List<ListsModel>> fetchLists() async {
    var result = await getDataCollectionCurrentUserOrderBy('date');
    itemList = result.docs
        .map((doc) => ListsModel.fromMap(doc.data(), doc.id))
        .toList();
    return itemList;
  }

  Stream<QuerySnapshot> fetchListsAsStream() {
    return streamDataCollectionCurrentUserOrderBy('date');
  }

  Future removeList(String id) async {
    await removeDocument(id);
    return;
  }

  Future addList(String title, String description) async {
    String uid = FirebaseAuth.instance.currentUser.uid;

    Map<String, dynamic> data = new Map();
    data.putIfAbsent('title', () => title);
    data.putIfAbsent('description', () => description);
    data.putIfAbsent('status', () => 'T');
    data.putIfAbsent('date', () => Timestamp.now());
    data.putIfAbsent('members', () => [uid]);

    await addDocument(data);
  }

  Future<QuerySnapshot> getDataCollectionCurrentUserOrderBy(String orderBy) {
    return ref
        .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .orderBy(orderBy, descending: true)
        .get();
  }

  Stream<QuerySnapshot> streamDataCollectionCurrentUserOrderBy(String orderBy) {
    return ref
        .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .orderBy(orderBy, descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }

  Stream<QuerySnapshot> fetchListsAsStreamByStatus(String statusSelected) {
    return ref
        .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .where('status', isEqualTo: statusSelected)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
