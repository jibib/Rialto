import 'package:flutter/material.dart';
import 'package:rialto/pages/main/explore/explore_page.dart';
import 'package:rialto/pages/main/explore/filler_page.dart';
import 'package:rialto/pages/main/profile.dart';

class NavigationPageViewer extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _NavigationPageViewerState();
  }
}

class _NavigationPageViewerState extends State<NavigationPageViewer> {
  int _currentIndex = 0;
  final List<NavigationPage> _children = [
    HomePage(),
    Profile(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: new Text('Explore'),
          ),

          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile'),
          )
        ],
      ),
    );
  }

  Widget buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/images/desk.jpg'),
        Image.asset('assets/images/desk.jpg'),
        Image.asset('assets/images/desk.jpg')
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

abstract class NavigationPage implements Widget {}
