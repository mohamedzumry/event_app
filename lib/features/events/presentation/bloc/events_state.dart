part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();  

  @override
  List<Object> get props => [];
}
class EventsInitial extends EventsState {}
