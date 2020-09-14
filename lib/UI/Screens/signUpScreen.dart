import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/Authentication_signUp/Bloc/signup_bloc.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';
import 'package:my_farm_app/UI/Widgets/signup.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/signup";
  final AuthenticationRepo _authenticationRepo;
  SignUpScreen({@required AuthenticationRepo authenticationRepo})
      : _authenticationRepo = authenticationRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: BlocProvider<AuthenticationsignupBloc>(
        create: (context) => AuthenticationsignupBloc(
          authenticationRepo: _authenticationRepo,
        ),
        child: SignUpForm(
          authenticationRepo: _authenticationRepo,
        ),
      ),
    );
  }
}
