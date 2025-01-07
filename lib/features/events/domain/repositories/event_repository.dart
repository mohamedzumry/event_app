import 'package:event_app/features/events/domain/entities/event.dart';

abstract class EventRepository {
  Future<void> addEvent(Event event);
  Future<void> updateEvent(Event event);
  Future<void> deleteEvent(String id);
  Stream<List<Event>> getEvents();
}
