import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:event_app/features/events/presentation/widgets/events_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    if (user != null) {
      context.read<EventsBloc>().add(LoadEventsByUserEvent(user!.uid));
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<EventsBloc>().add(LoadEventsByUserEvent(user!.uid));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'My Events',
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.goNamed('createEvent'),
            icon: const Icon(Icons.create_rounded),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomBar(selectedIndex: 2),
      body: BlocBuilder<EventsBloc, EventsState>(
        bloc: context.read<EventsBloc>(),
        builder: (context, state) {
          if (state is EventLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EventLoadSuccess) {
            final events = state.events;
            if (events.isEmpty) {
              return Center(child: Text('No events found.'));
            }
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  event: event,
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load events.'));
          }
        },
      ),
    );
  }
}
