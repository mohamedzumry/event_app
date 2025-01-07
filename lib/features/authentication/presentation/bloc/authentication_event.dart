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
  const SignUpWithGoogleUsingEmailPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
