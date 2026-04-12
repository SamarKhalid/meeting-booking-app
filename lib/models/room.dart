class Room {
  final int id;
  final String name;
  final int capacity;

  Room({
    required this.id,
    required this.name,
    required this.capacity,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] != null ? json['id'] as int : 0,
      name: json['name'] != null ? json['name'].toString() : 'Unknown Room',
      capacity: json['capacity'] != null ? json['capacity'] as int : 0,
    );
  }
}
