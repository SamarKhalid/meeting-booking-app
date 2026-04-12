import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/rooms_bloc/rooms_bloc.dart';
import '../blocs/rooms_bloc/rooms_event.dart';
import '../blocs/rooms_bloc/rooms_state.dart';
import 'room_details_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_field.dart';
import '../widgets/room_card.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomsBloc>().add(LoadRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Available Rooms'),
      body: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          if (state is RoomsLoading || state is RoomsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomsError) {
            return Center(child: Text(state.message));
          } else if (state is RoomsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchField(
                    hintText: 'Search for rooms...',
                    onChanged: (text) {
                      context.read<RoomsBloc>().add(FilterRoomsEvent(text));
                    },
                  ),
                ),
                Expanded(
                  child: state.filteredRooms.isEmpty
                      ? const Center(child: Text('No rooms found matching your search.'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.filteredRooms.length,
                          itemBuilder: (context, index) {
                            final room = state.filteredRooms[index];
                            return RoomCard(
                              room: room,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RoomDetailsScreen(room: room),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
