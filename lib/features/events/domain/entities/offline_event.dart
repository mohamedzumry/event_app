class OfflineEvent {
  final int? id;
  final String? onlineEventId;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String thumbnailPath;
  final String organizerId;
  final String organizerName;
  final String category;

  OfflineEvent({
    this.id,
    this.onlineEventId,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.thumbnailPath,
    required this.organizerId,
    required this.organizerName,
    required this.category,
  });
}
