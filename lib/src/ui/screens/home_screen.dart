import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top:50.0,bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Addow'),
              ElevatedButton.icon(
                onPressed: ()=>_logout(context),
                label: Text('Signout'),
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(),
      body: Container(),
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthenticationBloc>().add(LoggedOut());
  }
}
