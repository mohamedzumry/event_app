import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/repositories/event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository eventRepository;
  EventsBloc({required this.eventRepository}) : super(EventsInitial()) {
    on<EventsEvent>((event, emit) {});

    on<EventLoad>((event, emit) async {
      emit(EventLoadInProgress());
      try {
        final events = await eventRepository.getEvents().first;
        emit(EventLoadSuccess(events));
      } catch (_) {
        emit(EventOperationFailure());
      }
    });
    on<CreateEvent>((event, emit) async {
      try {
        await eventRepository.addEvent(event.event);
        add(EventLoad());
      } catch (_) {
        emit(EventOperationFailure());
      }
    });
    on<UpdateEvent>((event, emit) async {
      try {
        await eventRepository.updateEvent(event.event);
        add(EventLoad());
      } catch (_) {
        emit(EventOperationFailure());
      }
    });
    on<DeleteEvent>((event, emit) async {
      try {
        await eventRepository.deleteEvent(event.eventId);
        add(EventLoad());
      } catch (_) {
        emit(EventOperationFailure());
      }
    });
  }
}
