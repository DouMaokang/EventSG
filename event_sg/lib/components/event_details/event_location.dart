import 'package:flutter/material.dart';

class EventLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
      ],
    );
  }
}
