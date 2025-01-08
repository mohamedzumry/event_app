import 'package:firebase_auth/firebase_auth.dart';
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
        FirebaseAuth.instance.currentUser == null
            ? context.goNamed('signIn')
            : context.goNamed('profile');
      }
    }

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: widget.selectedIndex,
      onTap: onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: FirebaseAuth.instance.currentUser != null
              ? Icon(Icons.account_box_rounded)
              : Icon(Icons.login),
          label: 'Profile',
        ),
      ],
    );
  }
}
