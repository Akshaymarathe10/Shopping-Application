import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';

part 'authenticationlogin_event.dart';
part 'authenticationlogin_state.dart';

class AuthenticationloginBloc
    extends Bloc<AuthenticationloginEvent, AuthenticationloginState> {
  AuthenticationRepo _authRepo;
  AuthenticationloginBloc({@required AuthenticationRepo authenticationRepo})
      : assert(authenticationRepo != null),
        _authRepo = authenticationRepo,
        super(null);

  @override
  AuthenticationloginState get initialState => AuthenticationloginInitial();

  @override
  Stream<AuthenticationloginState> mapEventToState(
    AuthenticationloginEvent event,
  ) async* {
    AuthResult result;
    if (event is LogInEvent) {
      yield AuthenticationloginLoading();
      try {
        result = await _authRepo.logInUser(event.email, event.password);
        yield AuthenticationloginLoaded(result.user);
      } catch (e) {
        yield AuthenticationloginError(e.code);
      }
    }
  }
}
