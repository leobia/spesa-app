import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/core/models/itemListModel.dart';
import 'package:spesa_app/core/services/api.dart';
import 'package:spesa_app/locator.dart';

//https://medium.com/flutter-community/flutter-firebase-realtime-database-crud-operations-using-provider-c242a01f6a10
class ItemListCRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<ItemList> itemList;

  Future<List<ItemList>> fetchLists() async {
    var result = await _api.getDataCollectionCurrentUser();
    itemList =
        result.docs.map((doc) => ItemList.fromMap(doc.data(), doc.id)).toList();
    return itemList;
  }

  Stream<QuerySnapshot> fetchListsAsStream() {
    return _api.streamDataCollectionCurrentUser();
  }

  Future removeList(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future addList(String title, String budget) async {
    String uid = FirebaseAuth.instance.currentUser.uid;

    Map<String, dynamic> data = new Map();
    data.putIfAbsent('title', () => title);
    data.putIfAbsent('budget', () => budget);
    data.putIfAbsent('date', () => Timestamp.now());
    data.putIfAbsent('members', () => [uid]);
    data.putIfAbsent('items', () => []);

    await _api.addDocument(data);
  }
}
