import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:flutter/material.dart';

import '../sub_pages/events_created.dart';
import '../sub_pages/events_saved.dart';

/// This is the stateful widget that the main application instantiates.
class UserAccount extends StatefulWidget {
  const UserAccount({Key key}) : super(key: key);


  @override
  _UserAccountState createState() => _UserAccountState();
}


class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          title: Align (
              alignment: Alignment.center,
              child: const Text('Profile')
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
              CircleAvatar(
                radius: 90.0,
                backgroundImage:
                NetworkImage('https://silentmouth.com/wp-content/uploads/2010/11/facebook-generic-profile-pic-i.jpg'),
                backgroundColor: Colors.blue,

              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "User Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                      child: Align(
                        child: Text(
                          " Edit/View Profile",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    SizedBox(height: 6,),
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
                      leading: Icon(Icons.create),
                      title: Text('Events Created'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventsCreated()));
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
                            MaterialPageRoute(builder: (context) => EventsRegistered()));
                      },
                    ),
                   /* Divider(height: 0, indent: 16, endIndent: 16,),
                    ListTile(
                      leading: Icon(Icons.save_alt),
                      title: Text('Events Saved'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                           MaterialPageRoute(builder: (context) => EventSaved()));
                      },
                    ),*/
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
                      onTap: (){},

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

