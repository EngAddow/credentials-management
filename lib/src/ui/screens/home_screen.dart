import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

      int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
 final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
     drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Addow',
                style: textTheme.headline6,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Item 1'),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Item 2'),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text('Item 3'),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
          
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              selected: _selectedDestination == 3,
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: Container(),
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthenticationBloc>().add(LoggedOut());
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
