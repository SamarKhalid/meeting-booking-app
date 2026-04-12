import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/room.dart';
import '../models/booking.dart';

class ApiService {
  static const String baseUrl = 'https://employeevoice.hub2.icall.com.eg';

  Future<List<Room>> getRooms() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/items/rooms'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Room.fromJson(json)).toList();
      } else {
        throw Exception('Status ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load rooms: $e');
    }
  }

  Future<List<Booking>> getBookings(int roomId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/items/bookings?filter[room_id][_eq]=$roomId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/items/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)['data'];
      return Booking.fromJson(data);
    } else {
      throw Exception('Failed to create booking');
    }
  }
}
