import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'rooms_event.dart';
import 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final ApiService _apiService;

  RoomsBloc(this._apiService) : super(RoomsInitial()) {
    on<LoadRoomsEvent>((event, emit) async {
      emit(RoomsLoading());
      try {
        final rooms = await _apiService.getRooms();
        emit(RoomsLoaded(rooms, rooms));
      } catch (e) {
        emit(RoomsError(e.toString()));
      }
    });

    on<FilterRoomsEvent>((event, emit) {
      if (state is RoomsLoaded) {
        final currentState = state as RoomsLoaded;
        final query = event.query.toLowerCase();
        final filteredList = currentState.allRooms.where((room) {
          return room.name.toLowerCase().contains(query);
        }).toList();
        emit(RoomsLoaded(currentState.allRooms, filteredList));
      }
    });
  }
}
