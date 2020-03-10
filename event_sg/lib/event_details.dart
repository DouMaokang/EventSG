import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class EventDetails extends StatefulWidget {

  @override
  _EventDetailsState createState() => _EventDetailsState();
}


class _EventDetailsState extends State<EventDetails> {
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
            alignment: Alignment.centerLeft,
            child: const Text('Event Name')
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.turned_in_not),
            tooltip: 'Show saved events',
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
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
                      image: DecorationImage(
                        image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "My Awsome & Beautiful Event Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  // backgroundImage: NetworkImage("https://www.google.com/search?q=avatar&rlz=1C5CHFA_enSG870SG870&sxsrf=ALeKk01ZB_kccSzXhcuaCj9dP5JJgMc9nA:1583481201993&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjRlbaUr4XoAhVYU30KHWQsA_UQ_AUoAXoECBoQAw&biw=1440&bih=766#imgrc=1kWJ57V_tHBfrM"),
                ),
                title: Text(
                  'My awsome event organizer name',
                  style: TextStyle(
                      fontSize: 16),
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 16),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    FlatButton(
//                      child: Text(
//                        "Save",
//                        style: TextStyle(
//                          color: Colors.white,
//                        ),
//                      ),
//                      onPressed: () {},
//                      color: Colors.purple,
//                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
//
//                    ),
//                    FlatButton(
//                      child: Text(
//                        "Check In",
//                        style: TextStyle(
//                          color: Colors.white,
//                        ),
//                      ),
//                      onPressed: () {},
//                      color: Colors.purple,
//                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//
//                    ),
//                    FlatButton(
//                      child: Text(
//                        "Register",
//                        style: TextStyle(
//                          color: Colors.white,
//                        ),
//                      ),
//                      onPressed: () {},
//                      color: Colors.purple,
//                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                    ),
//
//                  ],
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        child: Text(
                          "Registration",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    SizedBox(height: 4,),
                    const ListTile(
                      leading: Icon(Icons.timer),
                      title: Text('Event Date & Time'),
                      subtitle: Text('Sat, 7 Mar 2020 3:30 PM - 5:30 PM'),
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    const ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Registration Deadline'),
                      subtitle: Text('Sat, 7 Mar 2020 3:30 PM'),
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16,),
                    const ListTile(
                      leading: Icon(Icons.event_seat),
                      title: Text('Vacancy'),
                      subtitle: Text('30 out of 50 vacancies are still available'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16,),
              ExpandableNotifier(
                child: ScrollOnExpand(
                  child: ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        child: Text(
                          "Description",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("This is a wonderful event that you and your friends will enjoy. You should definately not miss this opportunity to join us!",
                        softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("This is a wonderful event that you and your friends will enjoy. You should definately not miss this opportunity to join us! We have prepared various actities, food and drinks for you. Come and join us! You'll never regret your decision!",
                        softWrap: true, ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text(
                            "Location",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(height: 16),
                        Align(
                          child: Text(
                            "xxx road xxx street xxx house",
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                  ),
                  Container( // Map
                      padding: EdgeInsets.symmetric(vertical: 100),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://lh3.googleusercontent.com/-bQzIWFMAYus/WXy3WDcphBI/AAAAAAAAAMs/unOi6HiEoi4VWaM0WiP5q32q9zDbIhUvwCLcBGAs/s1600/7-29-2017%2B11-14-59%2BAM.jpg'),
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Address XXX Address XXX",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                    ),
                    Text(
                      "Detailed address xxx, 1234-5678",
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: IconButton(
                            icon: Icon(Icons.directions_car, color: Colors.blue),
                          ),
                        ),
                        SizedBox(width: 16,),
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: IconButton(
                            icon: Icon(Icons.directions_walk, color: Colors.blue),
                          ),
                        ),
                        SizedBox(width: 16,),
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: IconButton(
                            icon: Icon(Icons.directions_bus, color: Colors.blue),

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("@All Right Reserved"),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                  Icons.favorite_border,
                color: Colors.white,
              ),

            ),
            ButtonBar(
                children: [
                  FlatButton(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      color: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),

                ]
            )

          ],
        ),
      ),
    );
  }
}
