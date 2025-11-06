/// Event model for conferences and community events
class EventModel {
  final String id;
  final String nameKey;
  final String? descriptionKey;
  final DateTime date;
  final String? location;
  final String? url;

  const EventModel({
    required this.id,
    required this.nameKey,
    this.descriptionKey,
    required this.date,
    this.location,
    this.url,
  });
}
