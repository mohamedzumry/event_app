import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<EventsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
