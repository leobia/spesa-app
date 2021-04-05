import 'package:flutter/material.dart';

class NewListsView extends StatefulWidget {
  NewListsView({Key key}) : super(key: key);

  @override
  _NewListsViewState createState() => _NewListsViewState();
}

class _NewListsViewState extends State<NewListsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: TextFormField(),
        ),
      ),
    );
  }
}
