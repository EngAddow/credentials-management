import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/login/login_bloc.dart';
import 'package:flutter_app/src/common/utils.dart';
import 'package:flutter_app/src/ui/widgets/raised_button_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 15.0),
            RaisedButtonIcon(
              onPressed:_fingerprint,
              icon: Icons.fingerprint,
              label: 'Login with fingerprint',
            ),
            RaisedButtonIcon(
              onPressed: _showModal,
              icon: Icons.person,
              label: 'Login with email and password',
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _showModal() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      backgroundColor: Theme.of(context)
          .copyWith(backgroundColor: Colors.grey[400])
          .backgroundColor,
      context: context,
      enableDrag: true,
      builder: (BuildContext context2) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Login'),
                _buildEmailField(),
                _buildPasswordField(),
                BlocConsumer<LoginBloc, LoginState>(
                  cubit: context.read<LoginBloc>(),
                  builder: (context, state) {
                    return ElevatedButton(
                      child: state is LoginIsInProgress
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                      onPressed: _validateAndLogin,
                    );
                  },
                  listener: (context, state) {
                    if (state is LoginSucces) {
                      Navigator.maybePop(context2);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _emailController,
        validator: Utils.isEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passwordController,
        validator: Utils.isNotEmpty,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  void _validateAndLogin() {
    if (_formKey.currentState.validate()) {
      context.read<LoginBloc>().add(
            LoginWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  void _fingerprint() async{

    var localAuth = LocalAuthentication();
bool didAuthenticate =
    await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to show account balance');
  log(didAuthenticate.toString());

  }
}
