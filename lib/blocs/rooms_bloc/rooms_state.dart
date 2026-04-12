import 'package:equatable/equatable.dart';
import '../../models/room.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();
  @override
  List<Object?> get props => [];
}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsLoaded extends RoomsState {
  final List<Room> allRooms;
  final List<Room> filteredRooms;

  const RoomsLoaded(this.allRooms, this.filteredRooms);

  @override
  List<Object?> get props => [allRooms, filteredRooms];
}

class RoomsError extends RoomsState {
  final String message;
  const RoomsError(this.message);
  @override
  List<Object?> get props => [message];
}
