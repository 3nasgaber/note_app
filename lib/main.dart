import 'package:flutter/material.dart';
import 'package:note_app/Screens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home:HomeSreen(),
      routes: {
        "/HomeScreen": (_) => new MyApp(),
      }
    );

  }
}

