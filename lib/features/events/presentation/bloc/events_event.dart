part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class EventLoad extends EventsEvent {
  const EventLoad();

  @override
  List<Object> get props => [];
}

class CreateEvent extends EventsEvent {
  final Event event;
  const CreateEvent(this.event);

  @override
  List<Object> get props => [event];
}

class UpdateEvent extends EventsEvent {
  final Event event;
  const UpdateEvent(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventsEvent {
  final String eventId;
  const DeleteEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}
