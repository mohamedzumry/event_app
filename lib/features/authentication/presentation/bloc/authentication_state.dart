part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class GoogleLoginSuccessState extends AuthenticationState {
  final User user;
  const GoogleLoginSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}

class GoogleLoginFailedState extends AuthenticationState {
  final String message;
  const GoogleLoginFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class UserLoginSuccessState extends AuthenticationState {
  final User user;
  const UserLoginSuccessState({required this.user});
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
  final User user;
  const UserRegistrationSuccessState({required this.user});
  @override
  List<Object> get props => [user];
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
