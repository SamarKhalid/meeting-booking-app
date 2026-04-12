import 'package:equatable/equatable.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();
  @override
  List<Object?> get props => [];
}

class LoadRoomsEvent extends RoomsEvent {}

class FilterRoomsEvent extends RoomsEvent {
  final String query;
  const FilterRoomsEvent(this.query);
  @override
  List<Object?> get props => [query];
}
