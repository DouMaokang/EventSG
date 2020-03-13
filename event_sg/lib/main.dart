import 'package:event_sg/homepage.dart';
import 'package:flutter/material.dart';
// We can import files from its package.
import 'event_details.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/homepage', // '/' is the default initialRoute.
  routes: {
    '/event_details': (context) => EventDetails(), // This is the base route.
    '/homepage': (context) => Homepage(),
  },

));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EventSG",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Homepage(title: "Home"),
    );
  }
}