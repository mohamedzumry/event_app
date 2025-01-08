import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/repositories/event_repository.dart';
import 'package:event_app/features/events/domain/repositories/offline_event_repository.dart';
import 'package:flutter/foundation.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository eventRepository;
  final OfflineEventRepository offlineEventRepository;
  EventsBloc(
      {required this.eventRepository, required this.offlineEventRepository})
      : super(EventsInitial()) {
    on<EventsEvent>((event, emit) {});
    on<LoadEventsEvent>(loadEventsEvent);
    on<CreateEventEvent>(createEventEvent);
    on<UpdateEventEvent>(updateEventEvent);
    on<DeleteEvent>(deleteEventEvent);
    on<LoadEventsByUserEvent>(loadEventsByUserEvent);
    on<SaveOfflineEventEvent>(saveOfflineEventEvent);
    on<DeleteOfflineEventEvent>(deleteOfflineEventEvent);
    on<LoadOfflineEventsEvent>(loadOfflineEventsEvent);
  }
  FutureOr<void> loadEventsEvent(
      LoadEventsEvent event, Emitter<EventsState> emit) async {
    emit(EventLoadInProgress());
    try {
      final events = await eventRepository.getEvents().first;
      emit(EventLoadSuccess(events));
    } catch (_) {
      emit(EventCreationFailureState());
    }
  }

  FutureOr<void> createEventEvent(
      CreateEventEvent event, Emitter<EventsState> emit) async {
    try {
      await eventRepository.addEvent(event.event);
      emit(EventSuccessfullyCreated(event.event));
    } catch (_) {
      emit(EventCreationFailureState());
    }
  }

  FutureOr<void> updateEventEvent(
      UpdateEventEvent event, Emitter<EventsState> emit) async {
    try {
      await eventRepository.updateEvent(event.event);
      add(LoadEventsEvent());
    } catch (_) {
      emit(EventCreationFailureState());
    }
  }

  FutureOr<void> deleteEventEvent(
      DeleteEvent event, Emitter<EventsState> emit) async {
    try {
      await eventRepository.deleteEvent(event.eventId);
      add(LoadEventsEvent());
    } catch (_) {
      emit(EventCreationFailureState());
    }
  }

  FutureOr<void> loadEventsByUserEvent(
      LoadEventsByUserEvent event, Emitter<EventsState> emit) async {
    emit(EventLoadInProgress());
    try {
      final events = await eventRepository.getEventsByUser(event.userId).first;
      emit(EventLoadSuccess(events));
    } catch (e) {
      emit(EventLoadFailure(message: 'Failed to load events'));
    }
  }

  // Offline Event Bloc Functions

  FutureOr<void> saveOfflineEventEvent(
      SaveOfflineEventEvent event, Emitter<EventsState> emit) {
    try {
      offlineEventRepository.addEvent(event.event);
      emit(OfflineEventSavedSuccessfullyState());
    } catch (e) {
      emit(OfflineEventSaveFailureState());
    }
  }

  FutureOr<void> deleteOfflineEventEvent(
      DeleteOfflineEventEvent event, Emitter<EventsState> emit) {
    try {
      offlineEventRepository.deleteEvent(event.eventId);
      emit(OfflineEventDeletedSuccessfullyState());
    } catch (e) {
      emit(OfflineEventDeletionFailureState());
    }
  }

  Future<void> loadOfflineEventsEvent(
      LoadOfflineEventsEvent event, Emitter<EventsState> emit) async {
    try {
      final offlineEvents = await offlineEventRepository.getMyEvents();
      emit(OfflineEventsLoadedSuccessfullyState(offlineEvents: offlineEvents));
    } catch (e) {
      debugPrint(e.toString());
      emit(OfflineEventsLoadFailureState());
    }
  }
}
