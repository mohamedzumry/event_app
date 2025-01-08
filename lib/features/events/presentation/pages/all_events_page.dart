import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:event_app/features/events/presentation/widgets/events_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
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
        centerTitle: true,
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
