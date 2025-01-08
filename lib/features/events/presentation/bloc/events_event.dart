part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class CreateEventEvent extends EventsEvent {
  final Event event;
  const CreateEventEvent(this.event);

  @override
  List<Object> get props => [event];
}

class TriggerEditEvent extends EventsEvent {}

class UpdateEventEvent extends EventsEvent {
  final Event event;
  const UpdateEventEvent(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventsEvent {
  final String eventId;
  const DeleteEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class LoadEventsEvent extends EventsEvent {
  const LoadEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadEventsByUserEvent extends EventsEvent {
  final String userId;
  const LoadEventsByUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

// Offline Events
class SaveOfflineEventEvent extends EventsEvent {
  final Event event;
  const SaveOfflineEventEvent(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteOfflineEventEvent extends EventsEvent {
  final String eventId;
  const DeleteOfflineEventEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class LoadOfflineEventsEvent extends EventsEvent {
  const LoadOfflineEventsEvent();

  @override
  List<Object> get props => [];
}
