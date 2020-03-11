import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MyFeedback.dart';

class Notifications extends StatefulWidget {
  @override
  NotificationsState createState() => NotificationsState();
}

// the random state should extends xx
class NotificationsState extends State<Notifications> {
  final List<MyFeedback> feedbacks = [
    MyFeedback("test headline", "test content", "assets/default.png", true),
    MyFeedback("test headline", "test content", "assets/default.png", false),
    MyFeedback("test headline", "test content", "assets/default.png", true),
    MyFeedback("test headline", "test content", "assets/default.png", true),
    MyFeedback("test headline", "test content", "assets/default.png", false),
    MyFeedback("test headline", "test content", "assets/default.png", true),
    MyFeedback("test headline", "test content", "assets/default.png", false),
    MyFeedback("test headline", "test content", "assets/default.png", false),
    MyFeedback("test headline", "test content", "assets/default.png", true),
    MyFeedback("test headline", "test content", "assets/default.png", false),
    MyFeedback("test headline", "test content", "assets/default.png", false),
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

  Widget _buildRow(MyFeedback notification) {
    int _act = 1;
    return Card(
      color: notification.read ? Colors.grey[50] : Colors.grey[300],
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
        enabled: _act == 2,
        onTap: () {},
      )
    );
  }
}