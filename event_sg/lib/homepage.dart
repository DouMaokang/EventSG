import 'package:flutter/material.dart';
import 'event_details.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Center(child: Text('Event A')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetailsPage()),
              );
            },
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Event B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Event C')),
          ),
        ],
      ),
    );
  }
}
