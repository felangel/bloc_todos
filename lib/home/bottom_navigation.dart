import 'package:bloc_todos/home/home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key key,
    @required this.activeTab,
    @required this.onTabChanged,
  }) : super(key: key);

  final HomeTab activeTab;
  final Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: HomeTab.values.indexOf(activeTab),
      onTap: onTabChanged,
      items: HomeTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == HomeTab.todos ? Icons.list : Icons.show_chart,
          ),
          title: Text(tab == HomeTab.stats ? 'Stats' : 'Todos'),
        );
      }).toList(),
    );
  }
}
