import 'package:flutter/material.dart';
// We can import files from its package.
import 'events_saved.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/events_saved', // '/' is the default initialRoute.
  routes: {
    '/events_saved': (context) => EventsSaved(), // This is the base route.
    '/': (context) => Home(),
  },

));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align (
            alignment: Alignment.center,
            child: const Text('Home Page')
        ),

      ),
      body: Center(
        child: Text("Home Page"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),

        ],
        type: BottomNavigationBarType.fixed, // We need to add this line when having > 3 icons.
      ),
    );
  }
}