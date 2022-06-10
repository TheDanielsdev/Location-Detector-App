import 'dart:html';

import 'package:flutter/material.dart';
import 'package:location_detector/pages/settings.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  final List<Widget> _pages = [Home(), Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          //to keep the state of each children of the bottom nav
          index: _index,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            selectedLabelStyle: const TextStyle(
                fontFamily: 'CerebriSansPro-Regular',
                fontWeight: FontWeight.w700),
            selectedItemColor: Colors.red,
            unselectedLabelStyle: const TextStyle(
                fontFamily: 'CerebriSansPro-Regular',
                fontWeight: FontWeight.w700),
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              )
            ]));
  }
}
