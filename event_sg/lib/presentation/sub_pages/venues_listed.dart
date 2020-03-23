import 'package:flutter/material.dart';


/// This is the stateful widget that the main application instantiates.
class MyVenues extends StatefulWidget {

  @override
  _MyVenuesState createState() => _MyVenuesState();
}


class _MyVenuesState extends State<MyVenues> {
  final TextStyle textstyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final InputDecoration decoration = InputDecoration(
    border: OutlineInputBorder(),);

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
                    "My Venues",
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
                    new InkWell(onTap: (){},

                      child: new Container(
                        width: 150,
                        height: 175,

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
                    new InkWell(onTap: (){},
                      child:new Container(

                        width: 150,
                        height: 160,
                        padding: const EdgeInsets.all(5.0),

                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " Venue 1\n \n",
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
                                text: "5 April, 2020\n15:00 - 18:30\n700 sq m",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: "\n\nAvailable",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 14),
                              )

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
                    new InkWell(onTap: (){},
                      child: new Container(
                        width: 150,
                        height: 160,
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
                    new InkWell(onTap: (){},
                      child: new Container(

                        width: 150,
                        height: 160,
                        padding: const EdgeInsets.all(5.0),

                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Venue 2\n \n",
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
                                text: "6 April, 2020\n15:00 - 18:30\n700 sq m",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: "\n\nRented",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14),
                              )

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
                    new InkWell(onTap: (){},
                      child: new Container(
                        width: 150,
                        height: 165,
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
                    new InkWell(onTap: (){},
                      child: new Container(

                        width: 150,
                        height: 165,
                        padding: const EdgeInsets.all(5.0),

                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Venue 3\n \n",
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
                                text: "7 April, 2020\n15:00 - 18:30\n700 sq m",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: "\n\nAvailable",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 14),
                              ),

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

