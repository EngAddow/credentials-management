import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: LoginScreen() //HomeScreen(),
        );
  }
}
