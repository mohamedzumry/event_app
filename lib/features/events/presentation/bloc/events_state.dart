part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class EventLoadInProgress extends EventsState {}

class EventLoadSuccess extends EventsState {
  final List<Event> events;
  const EventLoadSuccess(this.events);
}

class EventOperationFailure extends EventsState {}
