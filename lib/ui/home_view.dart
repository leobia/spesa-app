import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/net/flutterfire.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _itemField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('Items')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data.docs
                    .map(
                      (document) => Container(
                        child: Row(
                          children: [Text("${document.data()['text']}")],
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          new Flexible(
            child: new TextFormField(
              textAlign: TextAlign.left,
              controller: _itemField,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 15.0, 15.0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    var isAdded = await addItem(_itemField.text);
                    if (isAdded) {
                      _itemField.clear();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AddView()));
      //   },
      //   child: Icon(Icons.add, color: Colors.white),
      //   backgroundColor: Colors.blueAccent,
      // ),
    );
  }
}
