import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';

class EventCarouselTile extends StatefulWidget {
  final Event event;

  const EventCarouselTile({
    super.key,
    required this.event,
  });

  @override
  State<EventCarouselTile> createState() => _EventCarouselTileState();
}

class _EventCarouselTileState extends State<EventCarouselTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            // Image with error handling
            if (widget.event.thumbnail.isNotEmpty)
              Image.network(
                widget.event.thumbnail,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.42 - 150,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Title
                    Text(
                      widget.event.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Organized by
                    if (widget.event.organizerName.isNotEmpty)
                      Text(
                        'Organized By ${widget.event.organizerName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),

                    const SizedBox(height: 5),

                    // Description
                    Text(
                      widget.event.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 5),

                    // Event date
                    Row(
                      children: [
                        Icon(Icons.calendar_month, size: 20),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '${widget.event.date.substring(0, 10)}, ${widget.event.time}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Event location
                    Row(
                      children: [
                        Icon(Icons.location_pin, size: 20),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            widget.event.location,
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
