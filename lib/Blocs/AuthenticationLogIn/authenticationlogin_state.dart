part of 'authenticationlogin_bloc.dart';

abstract class AuthenticationloginState {}

class AuthenticationloginInitial extends AuthenticationloginState {}

class AuthenticationloginLoading extends AuthenticationloginState {}

class AuthenticationloginLoaded extends AuthenticationloginState {
  final firebaseUser;
  AuthenticationloginLoaded(this.firebaseUser);
}

class AuthenticationloginError extends AuthenticationloginState {
  final String errorMsg;
  AuthenticationloginError(this.errorMsg);
}
