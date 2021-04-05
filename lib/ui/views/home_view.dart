import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/ui_components/list_builder.dart';
import 'package:spesa_app/ui_components/top_bar.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedView = 0;

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
            TopBar(),
            Expanded(
              child: ListBuilder(),
            )
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Liste',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
      ],
      currentIndex: _selectedView,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: (index) {
        setState(() {
          _selectedView = index;
        });
      },
    );
  }
}
