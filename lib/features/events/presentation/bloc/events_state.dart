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

class EventLoadFailure extends EventsState {
  final String message;
  const EventLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EventCreationFailureState extends EventsState {
  const EventCreationFailureState();

  @override
  List<Object> get props => [];
}

class EventSuccessfullyCreated extends EventsState {
  final Event event;
  const EventSuccessfullyCreated(this.event);

  @override
  List<Object> get props => [event];
}
