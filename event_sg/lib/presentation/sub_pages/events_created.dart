import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:flutter/material.dart';



/// This is the stateful widget that the main application instantiates.
class EventsCreated extends StatefulWidget {

  @override
  _EventsCreatedState createState() => _EventsCreatedState();
}


class _EventsCreatedState extends State<EventsCreated> {
  final TextStyle textstyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final InputDecoration decoration = InputDecoration(
    border: OutlineInputBorder(),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Return to previous page',
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
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
                    "Events Created",
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
                    new InkWell(onTap:(){},
                      child: new Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'http://www.obrienprinting.com/wp-content/uploads/2013/09/logo-icon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),


                    SizedBox(
                      width: 20.0,
                    ),
                    new InkWell(onTap:(){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EventFeedbackPage())//todo pass in eventId here))
                        );
                    },
                      child: new Container(

                        width: 150,
                        height: 150,
                        padding: const EdgeInsets.all(5.0),

                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " Event 1\n \n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              WidgetSpan(
                                child: Icon(Icons.location_on, color: Colors.blue,
                                    size: 14),
                              ),
                              TextSpan(
                                text: " Marina Bay Sands\n\n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: " 5 April, 2020\n 15:00 - 18:30\n\n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(height: 1, indent: 16, endIndent: 16,),


              new Container(

                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new InkWell(onTap:(){},
                      child: new Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'http://www.obrienprinting.com/wp-content/uploads/2013/09/logo-icon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),


                    SizedBox(
                      width: 20.0,
                    ),
                    new InkWell(onTap:(){},
                      child: new Container(

                        width: 150,
                        height: 150,
                        padding: const EdgeInsets.all(5.0),

                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " Event 2\n \n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),

                              ),
                              WidgetSpan(
                                child: Icon(Icons.location_on, color: Colors.blue,
                                    size: 14),


                              ),
                              TextSpan(
                                text: " Marina Bay Sands\n\n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: " 6 April, 2020\n 15:00 - 18:30",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),



                            ],
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(height: 1, indent: 16, endIndent: 16,),


              new Container(

                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new InkWell(onTap:(){},
                      child: new Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'http://www.obrienprinting.com/wp-content/uploads/2013/09/logo-icon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),


                    SizedBox(
                      width: 20.0,
                    ),
                    new InkWell(onTap:(){},
                      child: new Container(

                        width: 150,
                        height: 150,
                        padding: const EdgeInsets.all(5.0),

                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " Event 3\n \n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),

                              ),
                              WidgetSpan(
                                child: Icon(Icons.location_on, color: Colors.blue,
                                    size: 14),


                              ),
                              TextSpan(
                                text: " Marina Bay Sands\n\n",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: " 7 April, 2020\n 15:00 - 18:30",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, indent: 16, endIndent: 16,),
            ],
          ),
        ),
      ),
    );
  }
}

