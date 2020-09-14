import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';

part 'authenticationsignup_event.dart';
part 'authenticationsignup_state.dart';

class AuthenticationsignupBloc
    extends Bloc<AuthenticationsignupEvent, AuthenticationsignupState> {
  AuthenticationRepo _authRepo;
  AuthenticationsignupBloc({@required AuthenticationRepo authenticationRepo})
      : assert(authenticationRepo != null),
        _authRepo = authenticationRepo,
        super(null);

  @override
  AuthenticationsignupState get initialState => AuthenticationsignupInitial();

  @override
  Stream<AuthenticationsignupState> mapEventToState(
    AuthenticationsignupEvent event,
  ) async* {
    AuthResult result;
    if (event is CreateUser) {
      yield AuthenticationsignupLoading();
      try {
        result = await _authRepo.registerUser(
            event.email, event.password, event.name, event.address);
        yield AuthenticationsignupLoaded(result.user);
      } catch (e) {
        switch (e.code) {
          case 'ERROR_WEAK_PASSWORD':
            yield AuthenticationsignupError('ERROR_WEAK_PASSWORD');
            break;
          case 'ERROR_INVALID_EMAIL':
            yield AuthenticationsignupError('ERROR_INVALID_EMAIL');
            break;
          case 'ERROR_EMAIL_ALREADY_IN_USE':
            yield AuthenticationsignupError('ERROR_EMAIL_ALREADY_IN_USE');
            break;
        }
      }
    }
  }
}
