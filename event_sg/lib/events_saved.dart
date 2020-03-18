import 'package:flutter/material.dart';



final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class EventSaved extends StatefulWidget {

  @override
  _EventSavedState createState() => _EventSavedState();
}

class _EventSavedState extends State<EventSaved> {
  final TextStyle textstyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final InputDecoration decoration = InputDecoration(border: OutlineInputBorder(),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Align(
            alignment: Alignment.centerLeft,
            child: const Text('Edit/View Profile')
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Personal Information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              new Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                      NetworkImage('https://silentmouth.com/wp-content/uploads/2010/11/facebook-generic-profile-pic-i.jpg'),
                      backgroundColor: Colors.blue,

                    ),
                    SizedBox(
                      width: 20.0,
                    ),

                    ButtonBar(
                        children: [
                          FlatButton(
                            child: Text(
                              "Change photo",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                            color: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          ),

                        ]
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name(*)'
                  ),

                ),


              ),
              SizedBox(height: 10),

              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),

                          border: OutlineInputBorder(),
                          labelText: 'Current Password(*)',
                        ),
                      ),
                    ),


                    SizedBox(width: 10.0,),
                    new Flexible(
                      child: new TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          labelText: 'New Password(*)',
                        ),
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 10),


              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),


                child:TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address(*)'
                  ),

                ),
              ),
              SizedBox(height: 10),
              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),

                child:TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number(*)'
                  ),

                ),
              ),
              SizedBox(height: 10),
              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),

                          border: OutlineInputBorder(),
                          labelText: 'Occupation',
                        ),
                      ),
                    ),


                    SizedBox(width: 10.0,),
                    new Flexible(
                      child: new TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          labelText: 'Organization',
                        ),
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 10),

              new Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child:TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                      border: OutlineInputBorder(),
                      labelText: '  Interests'
                  ),

                ),
              ),
              SizedBox(height: 30),

              ButtonBar(
                  children: [
                    FlatButton(
                      child: Text(
                        "Save changes",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}

