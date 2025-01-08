import 'dart:io';

import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/features/events/domain/entities/offline_event.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OfflineEventDetailsPage extends StatelessWidget {
  final OfflineEvent event;
  const OfflineEventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventsBloc, EventsState>(
      bloc: context.read<EventsBloc>(),
      listener: (context, state) {
        if (state is OfflineEventDeletedSuccessfullyState) {
          context.read<EventsBloc>().add(LoadOfflineEventsEvent());
          context.goNamed('savedEvents');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          title: event.title,
          automaticallyImplyLeading: true,
          actions: [
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
                                .add(DeleteOfflineEventEvent(event.id!));
                          })
                    ],
                  ),
                );
              },
            ),
          ],
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
                      image: FileImage(File(event.thumbnailPath)),
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
          ],
        ),
      ),
    );
  }
}
