import 'package:equatable/equatable.dart';
import '../../models/booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

class LoadBookingsEvent extends BookingEvent {
  final int roomId;
  const LoadBookingsEvent(this.roomId);
  @override
  List<Object?> get props => [roomId];
}

class CreateBookingEvent extends BookingEvent {
  final Booking booking;
  const CreateBookingEvent(this.booking);
  @override
  List<Object?> get props => [booking];
}
