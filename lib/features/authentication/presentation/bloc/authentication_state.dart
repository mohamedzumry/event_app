part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class UserLoggedInState extends AuthenticationState {
  final User user;
  const UserLoggedInState({required this.user});
  @override
  List<Object> get props => [user];
}

class UserLoginFailedState extends AuthenticationState {
  final String message;
  const UserLoginFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class UserRegistrationSuccessState extends AuthenticationState {
  const UserRegistrationSuccessState();
  @override
  List<Object> get props => [];
}

class UserRegistrationFailedState extends AuthenticationState {
  final String message;
  const UserRegistrationFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class UserLoggedOutState extends AuthenticationState {
  const UserLoggedOutState();
  @override
  List<Object> get props => [];
}
