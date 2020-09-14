part of 'authenticationlogin_bloc.dart';

abstract class AuthenticationloginEvent {}

class LogInEvent extends AuthenticationloginEvent {
  final String email;
  final String password;
  LogInEvent(this.email, this.password);
}
