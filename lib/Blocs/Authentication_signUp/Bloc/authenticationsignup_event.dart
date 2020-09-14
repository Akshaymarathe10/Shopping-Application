part of 'signup_bloc.dart';

abstract class AuthenticationsignupEvent {}

class CreateUser extends AuthenticationsignupEvent {
  final String email;
  final String password;
  final String name;
  final String address;
  CreateUser(this.email, this.password, this.name, this.address);
}
