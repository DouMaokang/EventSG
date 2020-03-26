import 'package:event_sg/presentation/sub_pages/post_second_page.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class EventPost extends StatefulWidget {
  const EventPost({Key key}) : super(key: key);


  @override
  _EventPostState createState() => _EventPostState();
}


class _EventPostState extends State<EventPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align (
            alignment: Alignment(-0.25,0.0),
            child: const Text('Post an Event 1/2')
        ),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: 28,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "1. Organization Information",
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  child: TextField(
                    obscureText:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Organizer (*)',
                      labelText: 'Organizer (*)',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  child: TextField(
                    obscureText:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Organization Name',
                      labelText: 'Organization Name',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 120,
                  child: TextField(
                    //keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    obscureText:false,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: 'Organization Descripton',
                      labelText: 'Organization Descripton',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  child: TextField(
                    obscureText:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Contact Number (*)',
                      labelText: 'Contact Number (*)',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  child: TextField(
                    obscureText:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email Address (*)',
                      labelText: 'Email Address (*)',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),


              SizedBox(height: 8,),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "( All * entries are mandatory )",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonBar(
                children: [
                  FlatButton(
                    child: Text(
                      " Save ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {},
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),

                ]
            ),
            ButtonBar(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>PostSecondPage()),
                      );
                    },
                    color: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),

                    child: Row(
                        children: <Widget>[
                          Text(
                            " Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.arrow_forward),
                        ]
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}

