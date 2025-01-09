class Event {
  final String? id;
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

  factory Event.fromJson(Map<String, dynamic> json, String id) {
    return Event(
      id: id,
      title: json['title'],
      location: json['location'],
      date: json['date'],
      time: json['time'],
      organizerId: json['organizerId'],
      organizerName: json['organizerName'],
      thumbnail: json['thumbnail'],
      category: json['category'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
}
