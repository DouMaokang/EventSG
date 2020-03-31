import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:flutter/material.dart';

import '../sub_pages/events_created.dart';
import '../sub_pages/events_saved.dart';

/// This is the stateful widget that the main application instantiates.
///
///

class UserLogout extends StatefulWidget {
  const UserLogout({Key key}) : super(key: key);



  @override
  _UserLogoutState createState() => _UserLogoutState();
}


class _UserLogoutState extends State<UserLogout> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Align (
            alignment: Alignment.centerLeft,
            child: const Text('Logout')

        ),


      ),


      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[



              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  width: double.infinity,
                  child: Image.asset('assets/image/event_sg_icon.png',height:300, fit:BoxFit.fill ),
                ),
              ),

              SizedBox(height: 16,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "You are logged out!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
              ),

              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Still want to continue?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name(*)'
                  ),

                ),


              ),
              SizedBox(height: 16,),
              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password(*)'
                  ),

                ),


              ),

              SizedBox(height: 16,),
              ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatButton(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      color: Colors.blueAccent,

                    ),

                  ]
              ),












            ],
          ),
        ),

      ),
    );



  }
}

