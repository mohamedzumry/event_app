import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/events/data/repositories/impl_event_repository.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/repositories/event_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  EventRepository eventRepository = ImplEventRepository();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeLoadEventsEvent>(homeLoadEventsEvent);
  }

  FutureOr<void> homeLoadEventsEvent(
      HomeLoadEventsEvent event, Emitter<HomeState> emit) async {
    emit(HomeEventsLoadingState());
    try {
      final allEvents = await eventRepository.getEvents().first;
      final currentDate = DateTime.now();

      final latestEventsList = allEvents
        // ..sort(
        //     (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)))
        ..take(10).toList();

      final upcomingEventsList = allEvents
          .where((event) => DateTime.parse(event.date).isAfter(currentDate))
          .take(10)
          .toList()
        ..sort(
            (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
      emit(HomeEventsLoadedState(
        latestEventsList: latestEventsList,
        upcomingEventsList: upcomingEventsList,
      ));
    } catch (e) {
      emit(HomeEventsLoadingError(message: e.toString()));
    }
  }
}
