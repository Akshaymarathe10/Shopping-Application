part of 'signup_bloc.dart';

abstract class AuthenticationsignupState {}

class AuthenticationsignupInitial extends AuthenticationsignupState {}

class AuthenticationsignupLoading extends AuthenticationsignupState {}

class AuthenticationsignupLoaded extends AuthenticationsignupState {
  final firebaseUser;
  AuthenticationsignupLoaded(this.firebaseUser);
}

class AuthenticationsignupError extends AuthenticationsignupState {
  final String errorMsg;
  AuthenticationsignupError(this.errorMsg);
}
