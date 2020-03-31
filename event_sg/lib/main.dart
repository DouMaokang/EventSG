import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:event_sg/presentation/pages/notifications.dart';
import 'package:event_sg/presentation/pages/pages.dart';
import 'package:event_sg/presentation/pages/user_login.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'globals/login.dart';
import 'blocs/blocs.dart';


void main() {

  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );



  runApp(EventSG(eventRepository: eventRepository,));
}

class EventSG extends StatelessWidget {



  final EventRepository eventRepository;

  EventSG({ Key key,
    @required this.eventRepository,
  })
      : assert(eventRepository != null),
        super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => UserLogin(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),


//      home: App(),
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

    Homepage(),
    PostPage(),
    Notifications(),
    UserAccount()

  ];


  int _selectedIndex = 0;


  Widget _bottomNavigationBar(int selectedIndex) => SizedBox(
    child: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home',
            style: TextStyle(fontSize: 13),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          title: Text('Post',
            style: TextStyle(fontSize: 13),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notifications',
            style: TextStyle(fontSize: 13),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text(
              'Profile',
            style: TextStyle(fontSize: 13),
          ),
        ),

      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed, // We need to add this line when having > 3 icons.
    ),

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

  @override
  Widget build(BuildContext context) {


    print(Login().getUserId());

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SingleEventBloc>(
              create: (contextA) => SingleEventBloc(eventRepository: eventRepository),
            ),
            BlocProvider<EventListBloc>(
              create: (contextB) => EventListBloc(eventRepository: eventRepository),
            ),
            BlocProvider<SearchBloc>(
              create: (contextC) => SearchBloc(eventRepository: eventRepository),
            ),
          ],
          child: pages[_selectedIndex],
        ),
      ),
    );
  }
}
