import 'package:event_app/features/events/domain/entities/event.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class OfflineSqfliteEvent {
  final int? id;
  final String? onlineEventId;
  final String title;
  final String location;
  final String date;
  final String time;
  final String organizerId;
  final String organizerName;
  final String thumbnail;
  final String category;
  final String description;

  OfflineSqfliteEvent({
    this.id,
    this.onlineEventId,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.organizerId,
    required this.organizerName,
    required this.thumbnail,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'onlineEventId': onlineEventId,
      'title': title,
      'location': location,
      'date': date,
      'time': time,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'thumbnail': thumbnail,
      'category': category,
      'description': description,
    };
  }

  factory OfflineSqfliteEvent.fromMap(Map<String, dynamic> map) {
    return OfflineSqfliteEvent(
      id: map['id'],
      onlineEventId: map['onlineEventId'],
      title: map['title'],
      location: map['location'],
      date: map['date'],
      time: map['time'],
      organizerId: map['organizerId'],
      organizerName: map['organizerName'],
      thumbnail: map['thumbnail'],
      category: map['category'],
      description: map['description'],
    );
  }

  Future<String> saveImageToLocalStorage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final filePath =
        '${documentDirectory.path}/thumbnail_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<OfflineSqfliteEvent> fromDomain(Event event) async {
    final instance = OfflineSqfliteEvent(
      onlineEventId: event.id,
      title: event.title,
      location: event.location,
      date: event.date,
      time: event.time,
      organizerId: event.organizerId,
      organizerName: event.organizerName,
      thumbnail: '',
      category: event.category,
      description: event.description,
    );
    final localThumbnailPath =
        await instance.saveImageToLocalStorage(event.thumbnail);
    return OfflineSqfliteEvent(
      onlineEventId: event.id,
      title: event.title,
      location: event.location,
      date: event.date,
      time: event.time,
      organizerId: event.organizerId,
      organizerName: event.organizerName,
      thumbnail: localThumbnailPath,
      category: event.category,
      description: event.description,
    );
  }
}
