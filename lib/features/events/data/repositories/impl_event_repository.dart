import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/repositories/event_repository.dart';

abstract class ImplEventRepository extends EventRepository {
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection('events');

  @override
  Future<void> addEvent(Event event) {
    return _eventCollection.add(event.toJson());
  }

  @override
  Future<void> updateEvent(Event event) {
    return _eventCollection.doc(event.id).update(event.toJson());
  }

  @override
  Future<void> deleteEvent(String id) {
    return _eventCollection.doc(id).delete();
  }

  @override
  Stream<List<Event>> getEvents() {
    return _eventCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
