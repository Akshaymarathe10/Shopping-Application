import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepo _authRepo;
  AuthenticationBloc({@required AuthenticationRepo authenticationRepo})
      : assert(authenticationRepo != null),
        _authRepo = authenticationRepo,
        super(null);

  @override
  AuthenticationState get initialState => UnInitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    FirebaseUser user;
    if (event is AppStarted) {
      user = await _authRepo.getUser();

      if (user != null) {
        yield Authenticated(user);
      } else {
        yield UnAuthenticated();
      }
    }
    if (event is LogOut) {
      await _authRepo.logOutUser();
      yield UnAuthenticated();
    }
  }
}
