import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/event_thumbnail.jpg'), // Event thumbnail
            SizedBox(height: 10),
            Text(
              'Karaoke Nights Event',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '🎵 Music',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              '\$30.00/Person',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_pin),
                SizedBox(width: 5),
                Text('USA £2 Street'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 5),
                Text('Sep 29 - 10:00 PM'),
              ],
            ),
            SizedBox(height: 5),
            Text(
              '8,000+ people have joined',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your invite friends functionality here
              },
              child: Text('Invite Friends'),
            ),
            Divider(),
            Text(
              'About Event',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Karaoke Nights Event brings together music lovers for an unforgettable evening of live performances, great vibes, and fun competition.',
            ),
            SizedBox(height: 20),
            Text(
              'Organizer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('SonicVibe Events'),
            Text('Organize Team'),
            Divider(),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 5),
                Text('Contact'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.message),
                SizedBox(width: 5),
                Text('Chat'),
              ],
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                // Add your view on map functionality here
              },
              child: Text('View on Map'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                // Add your book now functionality here
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
