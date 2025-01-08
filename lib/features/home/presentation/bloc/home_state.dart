part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeEventsLoadedState extends HomeState {
  final List<Event> latestEventsList;
  final List<Event> upcomingEventsList;
  const HomeEventsLoadedState(
      {required this.latestEventsList, required this.upcomingEventsList});

  @override
  List<Object> get props => [latestEventsList, upcomingEventsList];
}

class HomeEventsLoadingState extends HomeState {
  const HomeEventsLoadingState();

  @override
  List<Object> get props => [];
}

class HomeEventsLoadingError extends HomeState {
  final String message;
  const HomeEventsLoadingError({required this.message});

  @override
  List<Object> get props => [message];
}
