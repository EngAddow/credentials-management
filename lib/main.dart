

import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/src/blocs/login/login_bloc.dart';
import 'package:flutter_app/src/services/repositories/user_repository.dart';
import 'package:flutter_app/src/ui/screens/home_screen.dart';
import 'package:flutter_app/src/ui/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  Bloc.observer = SimpleBlocDelegate();

  runApp(BlocProvider(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: RepositoryProvider(
      create: (context) => UserRepository(),
      child: CredentialsManagementApp(),
    ),
  ));
}

class CredentialsManagementApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Credentials management app.',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 19.0, fontFamily: 'Hind'),
          ),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthenticationBloc,AuthState>(
          builder: (context,state)
           =>state is Authenticated
          ?HomeScreen()
          : BlocProvider<LoginBloc>(
            create: (context)=>LoginBloc(
              authenticationBloc: context.read<AuthenticationBloc>(),
              userRepository: context.read<UserRepository>(),
              ),
            child: LoginScreen(),
            )
          
          
          
          //TODO:....
          // =>state is Authenticated
          // ?HomeScreen()
          // :state is Unauthenticated
          // ? LoginScreen()
          // :SplashScreen(),
          ),
        
        
        );
  }
}
