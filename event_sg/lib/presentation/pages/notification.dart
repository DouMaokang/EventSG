import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/myNotification.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

// the random state should extends xx
class NotificationsState extends State<Notifications> {
  final List<MyNotification> notifications = [
    MyNotification("test headline", "test content", "assets/default.png", true),
    MyNotification("test headline", "test content", "assets/default.png", false),
    MyNotification("test headline", "test content", "assets/default.png", true),
    MyNotification("test headline", "test content", "assets/default.png", true),
    MyNotification("test headline", "test content", "assets/default.png", false),
    MyNotification("test headline", "test content", "assets/default.png", true),
    MyNotification("test headline", "test content", "assets/default.png", false),
    MyNotification("test headline", "test content", "assets/default.png", false),
    MyNotification("test headline", "test content", "assets/default.png", true),
    MyNotification("test headline", "test content", "assets/default.png", false),
    MyNotification("test headline", "test content", "assets/default.png", false),
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
    int _act = 1;
    return Card(
        color: notification.read ? Colors.grey[50] : Colors.grey[300],
        child: ListTile(
          leading: Image.network("https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg"),
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