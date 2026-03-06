class WaypointItem {
  final String? title;
  final String address;
  final String? imageUrl;
  final DateTime? dateTime;

  WaypointItem({
    this.title,
    required this.address,
    this.imageUrl,
    this.dateTime,
  });
}
