import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainBottomBar extends StatefulWidget {
  final int selectedIndex;

  const MainBottomBar({super.key, required this.selectedIndex});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      if (index == 0) {
        context.goNamed('home');
      } else if (index == 1) {
        context.goNamed('allEvents');
      } else if (index == 2) {
        context.goNamed('profile');
      }
    }

    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
