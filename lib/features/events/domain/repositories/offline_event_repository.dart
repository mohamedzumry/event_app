import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/entities/offline_event.dart';

abstract class OfflineEventRepository {
  Future<void> addEvent(Event event);
  Future<void> deleteEvent(int id);
  Future<List<OfflineEvent>> getMyEvents();
}
