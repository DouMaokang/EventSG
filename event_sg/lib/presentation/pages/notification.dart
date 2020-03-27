import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/myNotification.dart';
import '../sub_pages/event_feedback.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

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
        title: Text('Notifications'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              BlocProvider.of<EventListBloc>(context)
                  .add(GetAllEvents());
            },
          )

        ],
      ),
      // body: _buildSuggestions(),

      body: Center(
        child: BlocBuilder<EventListBloc, EventListState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is EventListLoaded) {
              return ListView.builder(
                itemBuilder: (context, int index) {
                  return new ListTile(
                    title: new Text('${state.eventList[index].title}'),
                  );
                },
                itemCount: state.eventList.length,
              );
            } else {
              return Text("GetAllEvents() Failed");
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
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
              MaterialPageRoute(builder: (context) => EventFeedbackPage()),
            );
          },
        )
    );
  }
}