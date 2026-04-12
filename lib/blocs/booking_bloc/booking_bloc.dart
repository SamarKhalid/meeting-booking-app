import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/booking.dart';
import '../../services/api_service.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import 'package:intl/intl.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final ApiService _apiService;
  List<Booking> _currentBookings = [];

  BookingBloc(this._apiService) : super(BookingInitial()) {
    on<LoadBookingsEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        _currentBookings = await _apiService.getBookings(event.roomId);
        emit(BookingsLoaded(_currentBookings));
      } catch (e) {
        emit(BookingError(e.toString()));
      }
    });

    on<CreateBookingEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        if (_hasOverlap(event.booking)) {
          emit(const BookingError('The selected time slot overlaps with an existing booking.'));
          emit(BookingsLoaded(_currentBookings));
          return;
        }

        final createdBooking = await _apiService.createBooking(event.booking);
        _currentBookings.add(createdBooking);
        emit(BookingSuccess(createdBooking));
        emit(BookingsLoaded(_currentBookings));
      } catch (e) {
        emit(BookingError(e.toString()));
        emit(BookingsLoaded(_currentBookings));
      }
    });
  }

  bool _hasOverlap(Booking newBooking) {
    DateTime parseTime(String timeStr) {
      if (timeStr.length == 5) timeStr += ':00';
      return DateFormat('HH:mm:ss').parse(timeStr);
    }

    for (var existing in _currentBookings) {
      if (existing.date == newBooking.date) {
        DateTime existingStart = parseTime(existing.startTime);
        DateTime existingEnd = parseTime(existing.endTime);
        DateTime newStart = parseTime(newBooking.startTime);
        DateTime newEnd = parseTime(newBooking.endTime);

        if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
          return true;
        }
      }
    }
    return false;
  }
}
