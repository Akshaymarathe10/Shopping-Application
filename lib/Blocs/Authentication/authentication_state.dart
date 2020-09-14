part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class UnInitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final FirebaseUser user;

  Authenticated(this.user);
}

class UnAuthenticated extends AuthenticationState {}
