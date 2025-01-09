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
  const EventSuccessfullyCreated();

  @override
  List<Object> get props => [];
}

class EventSuccessfullyUpdated extends EventsState {
  const EventSuccessfullyUpdated();

  @override
  List<Object> get props => [];
}

class EventDeletedSuccessfullyState extends EventsState {
  const EventDeletedSuccessfullyState();

  @override
  List<Object> get props => [];
}
// Offline Event States

class OfflineEventSavedSuccessfullyState extends EventsState {
  const OfflineEventSavedSuccessfullyState();

  @override
  List<Object> get props => [];
}

class OfflineEventSaveFailureState extends EventsState {
  const OfflineEventSaveFailureState();

  @override
  List<Object> get props => [];
}

class OfflineEventDeletedSuccessfullyState extends EventsState {
  const OfflineEventDeletedSuccessfullyState();

  @override
  List<Object> get props => [];
}

class OfflineEventDeletionFailureState extends EventsState {
  const OfflineEventDeletionFailureState();

  @override
  List<Object> get props => [];
}

class OfflineEventsLoadedSuccessfullyState extends EventsState {
  final List<OfflineEvent> offlineEvents;
  const OfflineEventsLoadedSuccessfullyState({required this.offlineEvents});

  @override
  List<Object> get props => [offlineEvents];
}

class OfflineEventsLoadFailureState extends EventsState {
  final String message;
  const OfflineEventsLoadFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
