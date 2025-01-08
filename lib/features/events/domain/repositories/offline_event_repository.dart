import 'package:event_app/features/events/domain/entities/event.dart';

abstract class OfflineEventRepository {
  Future<void> addEvent(Event event);
  Future<void> deleteEvent(String id);
  Future<List<Event>> getMyEvents();
}
