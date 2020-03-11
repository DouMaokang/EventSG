import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myFeedback.dart';

class FeedbackView extends StatefulWidget {
  @override
  FeedbackViewState createState() => FeedbackViewState();
}

// the random state should extends xx
class FeedbackViewState extends State<FeedbackView> {
  final List<MyFeedback> feedbacks = [
    MyFeedback("test headline", "test content", "assets/default.png", 1),
    MyFeedback("test headline", "test content", "assets/default.png", 5),
    MyFeedback("test headline", "test content", "assets/default.png", 3),
    MyFeedback("test headline", "test content", "assets/default.png", 4),
    MyFeedback("test headline", "test content", "assets/default.png", 4),
    MyFeedback("test headline", "test content", "assets/default.png", 3),
    MyFeedback("test headline", "test content", "assets/default.png", 5),
    MyFeedback("test headline", "test content", "assets/default.png", 4),
    MyFeedback("test headline", "test content", "assets/default.png", 3),
    MyFeedback("test headline", "test content", "assets/default.png", 2),
    MyFeedback("test headline", "test content", "assets/default.png", 4),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dehaze),
        title: Text('Feedbacks'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.favorite,
                color: Colors.white
            ),
            onPressed: () {},
          )
        ],
      ),
      //body: _buildSuggestions(), //todo create a new build function
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

  Widget _buildFeedbacks() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          return _buildRow(feedbacks[index]);
        });
  }

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  Widget _buildRow(MyFeedback feedback) {
    int _act = 1;
    return Card(
        child: ListTile(
          leading: Image.asset(feedback.image),
          title: Text(
            feedback.username,
            style: _biggerFont,
          ),
          subtitle: Text(feedback.content),
          isThreeLine: true,
          enabled: _act == 2,
          onTap: () {},
        )
    );
  }
}