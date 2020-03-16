import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class EventPost extends StatefulWidget {

  @override
  _EventPostState createState() => _EventPostState();
}


class _EventPostState extends State<EventPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
          },
        ),
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
                    obscureText:true,
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
                    obscureText:true,
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
                    obscureText:true,
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
                    obscureText:true,
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
                        MaterialPageRoute(builder: (context)=>_EventPostStateSe()),
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

class _EventPostStateSe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
          },
        ),
        title: Align (
            alignment: Alignment(-0.25,0.0),
            child: const Text('Post an Event 2/2')
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
                    "2. Event Details",
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
                    obscureText:true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Event Name (*)',
                      labelText: 'Event Name (*)',
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
                      hintText: 'Event Description',
                      labelText: 'Event Description',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 10.0, // has the effect of softening the shadow
                          spreadRadius: 5.0, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            2.0, // vertical, move down 10
                          ),
                        )],
                        image:DecorationImage(
                          fit:BoxFit.fitWidth,
                          image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 36,),
                        FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            //side: BorderSide(color: Colors.red)
                          ),
                          child: Text(
                            "+ Set Event Image",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {},
                          color: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  child: TextField(
                    obscureText:true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Event Date (*)',
                      labelText: 'Event Date (*)',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Container(
                      width: 175,
                      height: 48,
                      child: TextField(
                        obscureText:true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Starts (*)',
                          labelText: 'Starts (*)',
                        ),
                      ),
                    ),
                    Container(
                      width: 175,
                      height: 48,
                      child: TextField(
                        obscureText:true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ends (*)',
                          labelText: 'Ends (*)',
                        ),
                      ),
                    ),
                  ],),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 48,
                  child: TextField(
                    obscureText:true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Maximum Capacity',
                      labelText: 'Maximum Capacity',
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
                    obscureText:true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Registration Deadline',
                      labelText: 'Registration Deadline',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text (
                          "Location (*)",
                          style: TextStyle(fontSize:18),
                        ),
                        SizedBox(height:8,),
                        Padding(
                          padding:EdgeInsets.only(left:8),
                          child: FlatButton(
                            child: Text(
                              "+ Choose",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {},
                            color: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width:30,),
                    Text (
                        "// display location here\n"+"// second line _________\n"+"// third line ____________",
                        style: TextStyle(fontSize:18)),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "( All * entries are mandatory )",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36,),
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),

                    child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back),
                          Text(
                            "Back ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ]
                    ),
                  ),
                ]
            ),
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
                    child: Text(
                      " Post ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {},
                    color: Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),

                ]
            ),
          ],
        ),
      ),
    );
  }
}
