import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:flutter/material.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
      ),
      bottomNavigationBar: MainBottomBar(selectedIndex: 1),
      body: const Center(
        child: Text('All Events Page'),
      ),
    );
  }
}
