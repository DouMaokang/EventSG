import 'package:flutter/material.dart';
import 'notification_listview.dart';
import 'feedback_view.dart';
// We can import files from its package.
import 'event_details.dart';
import 'homepage.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/event_details', // '/' is the default initialRoute.
  routes: {
    '/': (context) => MyBottomNavBar(), // This is the base route.
    '/event_details': (context) => EventDetailsPage(),
  },

));


/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Notifications(),

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyBottomNavBar(),
    );
  }
}


class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Text("2"),
    Text("3"),
    Text("4"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar:
        BottomNavigationBar(
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed, // We need to add this line when having > 3 icons.
        )
    );
  }
}
