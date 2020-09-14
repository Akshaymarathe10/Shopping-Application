import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/Authentication_signUp/Bloc/signup_bloc.dart';
import 'package:my_farm_app/Blocs/CarouselImagesBloc/carouselimages_bloc.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';

import 'package:my_farm_app/Repository/db_repo.dart';
import 'package:my_farm_app/UI/Screens/dashBoard.dart';

class SignUpForm extends StatefulWidget {
  final AuthenticationRepo _authenticationRepo;
  final DBRepo _dbRepo;

  SignUpForm({@required AuthenticationRepo authenticationRepo, DBRepo dbRepo})
      : _authenticationRepo = authenticationRepo,
        _dbRepo = dbRepo;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  final formkey = GlobalKey<FormState>();

  AuthenticationsignupBloc _authenticationsignupBloc;

  AuthenticationRepo get _authRepo => widget._authenticationRepo;
  DBRepo get _dbRepo => widget._dbRepo;

  @override
  void initState() {
    _authenticationsignupBloc =
        BlocProvider.of<AuthenticationsignupBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationsignupBloc, AuthenticationsignupState>(
      listener: (context, state) {
        if (state is AuthenticationsignupLoading) {
          showSnackBar('Signing Up');
        }
        if (state is AuthenticationsignupLoaded) {
          BlocProvider.of<CarouselimagesBloc>(context).add(
            GetCarouselImages(),
          );
          return DashBoard(dbRepo: _dbRepo);
        }
        if (state is AuthenticationsignupError) {
          showSnackBar(state.errorMsg);
        }
      },
      child: BlocBuilder<AuthenticationsignupBloc, AuthenticationsignupState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter name" : null,
                    decoration: new InputDecoration(labelText: 'Name'),
                    controller: name,
                  ),
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
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter address" : null,
                    decoration: new InputDecoration(labelText: 'Address'),
                    controller: address,
                  ),
                  RaisedButton(
                    child: Text("Sign Up"),
                    elevation: 6.0,
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        _authenticationsignupBloc.add(
                          CreateUser(
                            email.text,
                            pass.text,
                            name.text,
                            address.text,
                          ),
                        );
                      } else {
                        print('Not Valid Cre');
                      }
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
