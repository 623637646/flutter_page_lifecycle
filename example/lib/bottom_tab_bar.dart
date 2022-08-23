import 'package:example/my_app_bar.dart';
import 'package:example/top_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_lifecycle/flutter_page_lifecycle.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    TopTabBar(bottomTabTitle: "Home"),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  static const List<BottomNavigationBarItem> _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? null
          : MyAppBar(
              title: _tabs[_selectedIndex].label!,
            ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                PageLifecycle(
                    stateChanged: (appeared) {
                      debugPrint(
                          "[Page][${appeared ? "appeared" : "disappeared"}] ${_tabs[i].label!}");
                    },
                    child: e),
              ),
            )
            .values
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
