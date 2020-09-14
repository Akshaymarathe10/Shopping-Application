import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';
import 'package:my_farm_app/Blocs/AuthenticationLogIn/authenticationlogin_bloc.dart';
import '../Widgets/logIn.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/';
  final AuthenticationRepo _authenticationRepo;
  LogInScreen({AuthenticationRepo authenticationRepo})
      : _authenticationRepo = authenticationRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider<AuthenticationloginBloc>(
        create: (context) => AuthenticationloginBloc(
          authenticationRepo: _authenticationRepo,
        ),
        child: LogInForm(
          authenticationRepo: _authenticationRepo,
        ),
      ),
    );
  }
}
