import 'package:event_sg/widgets/feedback_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myNotification.dart';

class Notifications extends StatefulWidget {
  @override
  NotificationsState createState() => NotificationsState();
}

// the random state should extends xx
class NotificationsState extends State<Notifications> {
  final List<MyNotification> notifications = [
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
    MyNotification("test headline", "test content", "assets/default.png", ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dehaze),
        title: Text('Notifications'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: Colors.white
            ),
            onPressed: () {},
          )
        ],
      ),
      body: _buildSuggestions(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text('Create')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildRow(notifications[index]);
        });
  }

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  Widget _buildRow(MyNotification notification) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(notification.image),
        title: Text(
          notification.title,
          style: _biggerFont,
        ),
        subtitle: Text("A sufficiently long subtitle warrants three lines."),
        trailing: Row(
          children:
            <Widget>[Icon(Icons.arrow_forward_ios)],
            mainAxisSize: MainAxisSize.min
        ),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedbackView()),
          );
        },
      )
    );
  }
}