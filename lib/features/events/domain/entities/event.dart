class Event {
  final int? id;
  final String title;
  final String location;
  final String date;
  final String time;
  final String organizerId;
  final String organizerName;
  final String thumbnail;
  final String category;
  final String description;

  Event({
    this.id,
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
}
