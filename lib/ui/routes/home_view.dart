import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spesa_app/ui/views/lists_view.dart';
import 'package:spesa_app/ui/views/placeholder_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ListsView(),
    PlaceholderView(Colors.deepOrange),
    PlaceholderView(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          iconSize: 25.0,
          backgroundColor: Colors.white,

          onTap: (value) => {
            setState(() {
              _currentIndex = value;
            })
          },
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.checkmark_circle_outline),
              label: 'Tasks',
              activeIcon: Icon(Ionicons.checkmark_circle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.heart_outline),
              label: 'Favorites',
              activeIcon: Icon(Ionicons.heart),
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.basketball_outline),
              label: 'Basketball',
              activeIcon: Icon(Ionicons.basketball),
            )
          ],
        ),
      ),
    );
  }
}
