import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/ui_components/list_builder.dart';
import 'package:spesa_app/ui_components/new_list.dart';
import 'package:spesa_app/ui_components/top_bar.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 10.0),
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 30.0),
            TopBar(
              title: "Liste",
              leftButton: SizedBox(
                width: 31.47,
              ),
              rightButton: IconButton(
                onPressed: () {
                  _showModalBottomSheet(context);
                },
                icon: Icon(Icons.add),
                color: Theme.of(context).accentColor,
              ),
            ),
            Expanded(
              child: ListBuilder(),
            )
          ],
        ),
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
    context: context,
    builder: (context) {
      return NewList();
    },
  );
}
