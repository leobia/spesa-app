import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/ui/views/lists_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListsView();
  }
}
