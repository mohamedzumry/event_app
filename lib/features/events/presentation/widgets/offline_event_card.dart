import 'dart:io';

import 'package:event_app/features/events/domain/entities/offline_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OfflineEventCard extends StatelessWidget {
  final OfflineEvent event;
  const OfflineEventCard({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('offlineEventDetails', extra: event),
      child: Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          leading: SizedBox(
            width: 75,
            height: 75,
            child: Image.file(File(event.thumbnailPath)),
          ),
          title: Text(
            event.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3),
              Row(
                children: [
                  Icon(Icons.location_pin, size: 20),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      event.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 20),
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
