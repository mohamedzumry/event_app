import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/presentation/widgets/events_temp_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: MainAppBar(
        title: 'All Events',
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.goNamed('myEvents'),
            icon: const Icon(Icons.event_note_rounded),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomBar(selectedIndex: 1),
      body: ListView(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          EventsTempCard(
            event: Event(
              title:
                  'Educational Workshops Event Educational Workshops Event Educational Workshops Event',
              location: 'UK',
              date: 'Sep 29',
              time: '10:00 PM',
              organizerId: user == null ? 'User Id' : user.uid,
              organizerName: user == null ? 'User Name' : user.displayName!,
              thumbnail: 'assets/images/all-events-dummy.png',
              category: 'Music',
              description:
                  'Description Description Description Description Description DescriptionDescription Description Description',
            ),
          ),
        ],
      ),
    );
  }
}
