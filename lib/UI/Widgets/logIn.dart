import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/AuthenticationLogIn/authenticationlogin_bloc.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
import '../Screens/signUpScreen.dart';
import 'package:my_farm_app/UI/Screens/dashBoard.dart';

class LogInForm extends StatefulWidget {
  final AuthenticationRepo _authenticationRepo;
  final DBRepo _dbRepo;
  LogInForm({AuthenticationRepo authenticationRepo, DBRepo dbRepo})
      : _authenticationRepo = authenticationRepo,
        _dbRepo = dbRepo;

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final formkey = GlobalKey<FormState>();

  AuthenticationloginBloc _authenticationloginBloc;

  AuthenticationRepo get _authRepo => widget._authenticationRepo;
  DBRepo get _dbRepo => widget._dbRepo;

  @override
  void initState() {
    _authenticationloginBloc =
        BlocProvider.of<AuthenticationloginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationloginBloc, AuthenticationloginState>(
      listener: (context, state) {
        if (state is AuthenticationloginLoading) {
          showSnackBar('Logging In');
        }
        if (state is AuthenticationloginLoaded) {
          return DashBoard(dbRepo: _dbRepo);
        }
        if (state is AuthenticationloginError) {
          showSnackBar(state.errorMsg);
        }
      },
      child: BlocBuilder<AuthenticationloginBloc, AuthenticationloginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (val) => !Validators.isValidEmail(val)
                        ? "Enter valid email"
                        : null,
                    decoration: new InputDecoration(labelText: 'Email'),
                    controller: email,
                  ),
                  TextFormField(
                    validator: (val) => val.length < 6
                        ? "Password lenght should greater than 6"
                        : null,
                    decoration: new InputDecoration(labelText: 'Password'),
                    controller: pass,
                  ),
                  RaisedButton(
                    child: Text("LogIn"),
                    elevation: 6.0,
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        _authenticationloginBloc
                            .add(LogInEvent(email.text, pass.text));
                      } else {
                        print('Not Valid Cre');
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Text("SignUp"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen(authenticationRepo: _authRepo);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showSnackBar(String msg) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Text(msg),
            ],
          ),
        ),
      );
  }

  successful() {
    print("in Successful");
  }
}

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
