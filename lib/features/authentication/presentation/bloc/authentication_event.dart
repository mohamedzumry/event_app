part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends AuthenticationEvent {
  const SignInWithGoogleEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithGoogleUsingEmailPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String displayName;
  const SignUpWithGoogleUsingEmailPasswordEvent(
      this.email, this.password, this.displayName);

  @override
  List<Object> get props => [email, password, displayName];
}

class SignInWithGoogleUsingEmailPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;
  const SignInWithGoogleUsingEmailPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthenticationEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}
