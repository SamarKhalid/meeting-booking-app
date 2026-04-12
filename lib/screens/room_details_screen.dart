import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/room.dart';
import '../blocs/booking_bloc/booking_bloc.dart';
import '../blocs/booking_bloc/booking_event.dart';
import '../blocs/booking_bloc/booking_state.dart';
import 'booking_screen.dart';
import '../widgets/custom_app_bar.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Room room;
  const RoomDetailsScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(LoadBookingsEvent(widget.room.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${widget.room.name} Bookings'),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (previous, current) => current is BookingsLoaded || current is BookingLoading || current is BookingInitial,
        builder: (context, state) {
          if (state is BookingLoading || state is BookingInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingsLoaded) {
            if (state.bookings.isEmpty) {
              return const Center(child: Text('No bookings for this room.'));
            }
            return ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final b = state.bookings[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Icon(Icons.event_available, color: Theme.of(context).primaryColor),
                    ),
                    title: Text('Date: ${b.date}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('${b.startTime} - ${b.endTime}\nBooked by: ${b.userName}'),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingScreen(room: widget.room),
            ),
          );
        },
        label: const Text('Book Room'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
