import 'package:event_app/core/database/database_helper.dart';
import 'package:event_app/features/events/data/models/offline_sqflite_event.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/repositories/offline_event_repository.dart';

class ImplOfflineEventRepository extends OfflineEventRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  @override
  Future<void> addEvent(Event event) async {
    final offlineEventModel = await OfflineSqfliteEvent.fromDomain(event);
    final db = await _databaseHelper.database;
    await db.insert('offline_events', offlineEventModel.toMap());
  }

  @override
  Future<void> deleteEvent(String id) async {
    final db = await _databaseHelper.database;
    await db.delete('offline_events', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Event>> getMyEvents() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('offline_events');
    return List.generate(maps.length, (i) {
      return OfflineSqfliteEvent.fromMap(maps[i]).toDomain();
    });
  }
}
