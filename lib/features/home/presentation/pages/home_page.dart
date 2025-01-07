import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/core/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Eventify',
        centerTitle: true,
        automaticallyImplyLeading: true,
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
