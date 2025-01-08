import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:event_app/features/events/presentation/widgets/events_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedEventsPage extends StatefulWidget {
  const SavedEventsPage({super.key});

  @override
  State<SavedEventsPage> createState() => _SavedEventsPageState();
}

class _SavedEventsPageState extends State<SavedEventsPage> {
  @override
  void initState() {
    context.read<EventsBloc>().add(LoadOfflineEventsEvent());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<EventsBloc>().add(LoadOfflineEventsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Saved Events',
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      bottomNavigationBar: MainBottomBar(selectedIndex: 2),
      body: BlocBuilder<EventsBloc, EventsState>(
        bloc: context.read<EventsBloc>(),
        builder: (context, state) {
          if (state is EventLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OfflineEventsLoadedSuccessfullyState) {
            final events = state.offlineEvents;
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
