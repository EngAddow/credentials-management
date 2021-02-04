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
  final GlobalKey<__CredentialsTextFieldState> _emailKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                const Text('Login'),
                // _buildEmailField(),
                _CredentialsTextField(
                  key: _emailKey,
                  controller: _emailController,
                  hint: 'Email',
                  validator: Utils.isEmail,
                  keyboard: TextInputType.emailAddress,
                ),
                _buildPasswordField(),
                BlocConsumer<LoginBloc, LoginState>(
                  cubit: context.read<LoginBloc>(),
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: _validateAndLogin,
                      child: state is LoginIsInProgress
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    );
                  },
                  listener: (context, state) {
                    if (state is LoginSucces) {
                      // Navigator.maybePop(context2);
                    }
                  },
                ),
              ],
            ),
          ),
          RaisedButtonIcon(
            onPressed: _fingerprint,
            icon: Icons.fingerprint,
            label: 'Login with fingerprint',
          ),
          // RaisedButtonIcon(
          //   onPressed: _showModal,
          //   icon: Icons.person,
          //   label: 'Login with email and password',
          // ),
        ],
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
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Login'),
                  _buildEmailField(),
                  _buildPasswordField(),
                  BlocConsumer<LoginBloc, LoginState>(
                    cubit: context.read<LoginBloc>(),
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: _validateAndLogin,
                        child: state is LoginIsInProgress
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
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
          ),
        );
      },
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _emailController,
        validator: Utils.isEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passwordController,
        validator: Utils.isNotEmpty,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(border: OutlineInputBorder()),
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
    _emailKey.currentState.validate();
    //if form key not work use individual keys
  }

  Future<void> _fingerprint() async {
    final localAuth = LocalAuthentication();
    final bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to show account balance');
    log(didAuthenticate.toString());
  }
}

class _CredentialsTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String> validator;
  final TextInputType keyboard;
  final FocusNode focusNode;
  final VoidCallback onFinished;
  final bool isPassword;
  final double horizontalPadding;
  final Function(String) onValueChanged;
  final String error;

  const _CredentialsTextField({
    Key key,
    @required this.controller,
    this.hint,
    this.validator,
    this.keyboard = TextInputType.text,
    this.focusNode,
    this.onFinished,
    this.isPassword = false,
    this.horizontalPadding = 16.0,
    this.onValueChanged,
    this.error,
  }) : super(key: key);

  @override
  __CredentialsTextFieldState createState() => __CredentialsTextFieldState();
}

class __CredentialsTextFieldState extends State<_CredentialsTextField> {
  String error;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextFormField(
                onChanged: widget.onValueChanged,
                controller: widget.controller,
                validator: widget.validator,
                keyboardType: widget.keyboard,
                focusNode: widget.focusNode,
                obscureText: widget.isPassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.hint,
                  hintText: widget.hint,
                  suffixIcon: error != null
                      ? Icon(
                          Icons.close,
                          color: style.errorColor,
                        )
                      : isChecked
                          ? const Icon(Icons.done)
                          : null,
                ),
              ),
            ),
          ),
          if (error != null)
            Text(
              error,
              style: TextStyle(color: style.errorColor),
            )
        ],
      ),
    );
  }

  String validate() {
    setState(() {
      error = widget.validator(widget.controller.text);
      if (error != null) isChecked = true;
    });
  }
}
