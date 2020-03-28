import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:event_sg/presentation/pages/notification.dart';
import 'package:event_sg/presentation/pages/pages.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  // todo i'm not sure
  final ReviewRepository reviewRepository = ReviewRepository(
    reviewApiClient: ReviewApiClient(httpClient: http.Client()),
  );

  final NotificationRepository notificationRepository = NotificationRepository(
    notificationApiClient: NotificationApiClient(httpClient: http.Client()),
  );


  runApp(EventSG(
    eventRepository: eventRepository,
    reviewRepository: reviewRepository,
    notificationRepository: notificationRepository,
  ));
}

class EventSG extends StatelessWidget {
  final EventRepository eventRepository;
  final ReviewRepository reviewRepository;
  final NotificationRepository notificationRepository;

  EventSG({ Key key,
    @required this.eventRepository, this.reviewRepository, this.notificationRepository
  })
      : assert(eventRepository != null && reviewRepository != null && notificationRepository != null),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState
    extends State<App> {
  final List<Widget> pages = [
    Homepage(
      key: PageStorageKey('home'),

    ),
    EventPost(
        key: PageStorageKey('post')
    ),
    Notifications(
      key: PageStorageKey('notification'),
    ),
    UserAccount(
        key: PageStorageKey('account')
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
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
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  final ReviewRepository reviewRepository = ReviewRepository(
    reviewApiClient: ReviewApiClient(httpClient: http.Client()),
  );

  final NotificationRepository notificationRepository = NotificationRepository(
    notificationApiClient: NotificationApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SingleEventBloc>(
            create: (contextA) => SingleEventBloc(eventRepository: eventRepository),
          ),
          BlocProvider<EventListBloc>(
            create: (contextB) => EventListBloc(eventRepository: eventRepository),
          ),
          BlocProvider<ReviewListBloc>(
            create: (contextC) => ReviewListBloc(reviewRepository: reviewRepository),
          ),
          BlocProvider<AddReviewBloc>(
            create: (contextD) => AddReviewBloc(reviewRepository: reviewRepository),
          ),
          BlocProvider<NotificationBloc>(
            create: (contextE) => NotificationBloc(notificationRepository: notificationRepository),
          )
        ],
        child: PageStorage(
          child: pages[_selectedIndex],
          bucket: bucket,
        ),
      ),


    );
  }
}