import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/repositories/event_repository.dart';
import 'package:flutter/material.dart';

class ImplEventRepository extends EventRepository {
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection('events');

  @override
  Future<void> addEvent(Event event) async {
    DocumentReference docRef = await _eventCollection.add(event.toJson());
    event = Event(
      id: docRef.id,
      title: event.title,
      location: event.location,
      date: event.date,
      time: event.time,
      organizerId: event.organizerId,
      organizerName: event.organizerName,
      thumbnail: event.thumbnail,
      category: event.category,
      description: event.description,
    );
    await docRef.update(event.toJson());
  }

  @override
  Future<void> updateEvent(Event event) async {
    try {
      DocumentReference docRef = _eventCollection.doc(event.id);
      debugPrint('Event updated with ID: ${event.id}');
      await docRef.update(event.toJson());
    } catch (e) {
      debugPrint('Failed to update event: $e');
    }
  }

  @override
  Future<void> deleteEvent(String id) {
    return _eventCollection.doc(id).delete();
  }

  @override
  Stream<List<Event>> getEvents() {
    return _eventCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  @override
  Stream<List<Event>> getEventsByUser(String userId) {
    return _eventCollection
        .where('organizerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
