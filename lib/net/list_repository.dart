import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
Structure: lists: [
  {
    id,
    members: [...uids],
    items: [{title: '', date: ''}]
  }
]
 */

Future<QuerySnapshot> getCurrentUserLists() {
  return FirebaseFirestore.instance
      .collection('lists')
      .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
      .orderBy('date')
      .get();
}

Future<bool> addList(String listTitle, String budget) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference lists = FirebaseFirestore.instance.collection('lists');

    print(budget);
    lists.add({
      'members': [uid],
      'title': listTitle,
      'budget': budget,
      'items': [],
      'date': DateTime.now()
    });

    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeList(String listId) async {
  try {
    // TODO
    await FirebaseFirestore.instance.collection('lists').doc(listId).delete();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> editList(String listId, String newListTitle) async {
  try {
    // TODO

    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> shareList(String listId, String newUser) async {
  try {
    // TODO

    return true;
  } catch (e) {
    return false;
  }
}
