import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/src/services/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithEmailAndPassword) {
       yield LoginIsInProgress();
    try {
      final token = await userRepository.signIn(
        email: event.email,
        password: event.password,
      );
      authenticationBloc.add(LoggedIn(token));
      yield LoginSucces();
    } catch (error) {
      yield LoginFailed(message: error.toString());
    }
    }else if(event is LoginWithFingerprint){
  authenticationBloc.add(LoggedIn('${event.authenticated}'));

    }

  }

}
