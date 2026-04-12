class Booking {
  final int? id;
  final int roomId;
  final String date;
  final String startTime;
  final String endTime;
  final String userName;

  Booking({
    this.id,
    required this.roomId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.userName,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int?,
      roomId: json['room_id'] as int,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      userName: json['user_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'user_name': userName,
    };
  }
}
