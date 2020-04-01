import 'package:event_sg/api_clients/user_api_client.dart';
import 'package:event_sg/globals/login.dart';
import 'package:event_sg/models/user.dart';
import 'package:event_sg/presentation/pages/user_login.dart';
import 'package:event_sg/presentation/sub_pages/profile_event_feedback.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:event_sg/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../sub_pages/events_created.dart';
import '../sub_pages/events_saved.dart';

/// This is the stateful widget that the main application instantiates.
class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}
class _UserAccountState extends State<UserAccount> {

  final UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(httpClient: http.Client())
  );

  Future myFutureUser;

  @override
  void initState() {
    super.initState();
    // assign this variable your Future
    myFutureUser = userRepository.getUserById(Login().getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          centerTitle: true,
          title: Align (
              alignment: Alignment.center,
              child: const Text('Profile', textAlign: TextAlign.center,)
          ),
          /*  actions: <Widget>[
           IconButton(
             icon: const Icon(Icons.turned_in_not),
             tooltip: 'Show saved events',
             onPressed: () {
             },
           ),
         ], */
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16,),
              Container(
                child: FutureBuilder(
                    future: myFutureUser,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return new Container();
                      User user = snapshot.data;
                      return new Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 90.0,
                            backgroundImage: AssetImage(user.image),
                            backgroundColor: Colors.grey,
                          ),
                          SizedBox(height: 16,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                user.userName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 4,),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Personal Information'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserInfo()));
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Events Saved'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventsSavedPage()));
                        // Login().logIn(email: "doum0001@gasadha.com", password: "dashjkdhasd"); todo error here
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.create),
                      title: Text('Events Created'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventsCreatedPage()));
                        // Login().logIn(email: "doum0001@gasadha.com", password: "dashjkdhasd"); todo error here
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => EventsCreated()));
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text('Events Registered'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventsRegisteredPage()));
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.rate_review),
                      title: Text('Event Feedbacks'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileEventFeedback()));
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.place),
                      title: Text('My Venues'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyVenues()));
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      title: Text('Add account'),
                      selected: true,
                      onTap: (){},
                    ),
                    ListTile(
                      title: Text('Log out',),
                      selected: true,
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => UserLogin()),
                        );
                      },

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

