part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}
