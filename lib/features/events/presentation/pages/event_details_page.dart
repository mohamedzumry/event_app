import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;
  const EventDetailsPage({super.key, required this.event});

  bool isCurrentUserOrganizer(Event event) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return event.organizerId == currentUser.uid;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: event.title,
        automaticallyImplyLeading: true,
        actions: isCurrentUserOrganizer(event)
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => context.goNamed('createEvent', extra: {
                    'event': event,
                    'isEditable': true,
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Event'),
                        content:
                            Text('Are you sure you want to delete this event?'),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () => context.pop(),
                          ),
                          TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                context
                                    .read<EventsBloc>()
                                    .add(DeleteEvent(event.id!));
                                context.goNamed('myEvents');
                              })
                        ],
                      ),
                    );
                  },
                ),
              ]
            : [],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(event.thumbnail),
                    height: 300,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.category),
                            SizedBox(width: 16),
                            Text(
                              event.category,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.location_pin),
                            SizedBox(width: 16),
                            Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 16),
                            Text(
                              '${event.date} - ${event.time}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        Text(
                          'About Event',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(event.description),
                        SizedBox(height: 20),
                        Text(
                          'Organizer',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(event.organizerName),
                        Text('Organize Team'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    context
                        .read<EventsBloc>()
                        .add(SaveOfflineEventEvent(event));
                  } else {
                    context.goNamed('signIn');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                child: Text('Save Event'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
