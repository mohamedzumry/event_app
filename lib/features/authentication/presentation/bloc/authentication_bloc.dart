import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<SignInWithGoogleEvent>(signInWithGoogleEvent);
    on<SignUpWithGoogleUsingEmailPasswordEvent>(
        signUpWithGoogleUsingEmailPasswordEvent);
    on<SignInWithGoogleUsingEmailPasswordEvent>(
        signInWithGoogleUsingEmailPasswordEvent);
    on<LogoutEvent>(logoutEvent);
    on<UpdateDisplayNameEvent>(updateDisplayNameEvent);
    on<UpdatePasswordEvent>(updatePasswordEvent);
  }

  FutureOr<void> signInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(GoogleLoginFailedState(
            message: 'User canceled the sign-in or not found.'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      emit(GoogleLoginSuccessState(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Exception: ${e.message}");
      if (e.code == 'account-exists-with-different-credential') {
        emit(GoogleLoginFailedState(
            message:
                'The account already exists with a different credential.'));
      } else if (e.code == 'invalid-credential') {
        emit(GoogleLoginFailedState(
            message: 'Error occurred while accessing credentials. Try again.'));
      } else {
        emit(GoogleLoginFailedState(
            message: 'Error occurred while accessing credentials. Try again.'));
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
      if (e.code == 'network-request-failed') {
        emit(GoogleLoginFailedState(
            message:
                'Network request failed. Please check your internet connection.'));
      } else {
        emit(GoogleLoginFailedState(
            message: 'Error occurred while accessing credentials. Try again.'));
      }
    } catch (e) {
      emit(GoogleLoginFailedState(message: e.toString()));
    }
  }

  FutureOr<void> signUpWithGoogleUsingEmailPasswordEvent(
      SignUpWithGoogleUsingEmailPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await userCredential.user?.updateDisplayName(event.displayName);
      await userCredential.user?.reload();
      emit(UserRegistrationSuccessState(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(UserRegistrationFailedState(
            message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(UserRegistrationFailedState(
            message: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(UserRegistrationFailedState(message: e.toString()));
    }
  }

  FutureOr<void> signInWithGoogleUsingEmailPasswordEvent(
      SignInWithGoogleUsingEmailPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(UserLoginSuccessState(user: credential.user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(UserLoginFailedState(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(UserLoginFailedState(message: 'Wrong password provided.'));
      }
    } catch (e) {
      emit(UserLoginFailedState(message: e.toString()));
    }
  }

  FutureOr<void> logoutEvent(
      LogoutEvent event, Emitter<AuthenticationState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(UserLoggedOutState());
  }

  FutureOr<void> updateDisplayNameEvent(
      UpdateDisplayNameEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(event.displayName);
      emit(UserDisplayNameUpdatedState(displayName: event.displayName));
    } catch (e) {
      emit(UserDisplayNameUpdateFailedState(
          message: 'Failed to update display name'));
    }
  }

  FutureOr<void> updatePasswordEvent(
      UpdatePasswordEvent event, Emitter<AuthenticationState> emit) {
    debugPrint(event.password);
    try {
      FirebaseAuth.instance.currentUser?.updatePassword(event.password);
      emit(UserPasswordUpdatedState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(UserPasswordUpdateFailedState(
            message: 'The password provided is too weak.'));
      } else if (e.code == 'requires-recent-login') {
        emit(UserPasswordUpdateFailedState(
            message:
                'The user must reauthenticate before this operation can be executed.'));
      }
    } catch (e) {
      emit(UserPasswordUpdateFailedState(message: 'Failed to update password'));
    }
  }
}
