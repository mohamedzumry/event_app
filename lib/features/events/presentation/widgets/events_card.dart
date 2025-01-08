import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('eventDetails', extra: event),
      child: Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: SizedBox(
            width: 75,
            height: 75,
            child: Image(image: NetworkImage(event.thumbnail)),
          ),
          title: Text(
            event.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_pin),
                  SizedBox(width: 5),
                  Text(event.location),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 5),
                  Text('${event.date}, ${event.time}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
