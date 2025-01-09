import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:event_app/features/events/presentation/widgets/events_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    context.read<EventsBloc>().add(LoadEventsEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<EventsBloc>().add(LoadEventsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'All Events',
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          //My Events Button
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () async {
                if (user == null) {
                  context.goNamed('signIn');
                } else {
                  //Nav to My Events
                  context.goNamed('myEventsFromAllEvents');
                }
              },
              style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(4),
                  side: WidgetStatePropertyAll(
                      BorderSide(color: Colors.blue.shade900)),
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              child: Text(
                "Go to My Events",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomBar(selectedIndex: 1),
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
            return ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: events.map((event) => EventCard(event: event)).toList(),
            );
          } else if (state is EventLoadFailure) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Failed to load events.'));
          }
        },
      ),
    );
  }
}
