import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/core/widgets/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventify'),
        actions: [
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    context.goNamed('auth');
                  },
                  icon: const Icon(Icons.account_box_rounded),
                )
              : IconButton(
                  onPressed: () {
                    context.goNamed('auth');
                  },
                  icon: const Icon(Icons.login),
                ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Text(
          'Selected Page Index: $_selectedIndex',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: MainBottomBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
