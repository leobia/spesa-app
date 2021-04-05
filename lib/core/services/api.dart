import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollectionCurrentUser() {
    return ref
        .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .orderBy('date', descending: true)
        .get();
  }

  Stream<QuerySnapshot> streamDataCollectionCurrentUser() {
    return ref
        .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .orderBy('date', descending: true)
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
}
