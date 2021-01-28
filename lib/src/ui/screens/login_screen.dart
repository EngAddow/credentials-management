import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/widgets/raised_button_icon.dart';

class LoginScreen extends StatelessWidget {
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
              onPressed: () {},
              icon: Icons.fingerprint,
              label: 'Login with fingerprint',
            ),
            RaisedButtonIcon(
              onPressed: () => _showModal(context),
              icon: Icons.person,
              label: 'Login with email and password',
            ),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet<void>(isScrollControlled: true,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      backgroundColor: Theme.of(context).copyWith(backgroundColor: Colors.grey[400]).backgroundColor,
      context: context,enableDrag: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Login'),
                _buildEmailField(),
                _buildPasswordField(),
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      
      ),
    );
  }

  _buildPasswordField() {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
       decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
    ),
     );
  }
}
