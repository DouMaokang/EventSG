import 'package:event_sg/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenueDetailPage extends StatelessWidget{
  final Venue venue;
  VenueDetailPage({Key key,@required this.venue}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Venue Details"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
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
            Text(
              venue.venueName,
            ),
            SizedBox(height: 10,),
            Text(
              venue.description,
            ),
            Text(
              venue.rentalFee.toString(),
            ),
            SizedBox(height: 10,),
            FlatButton(
              child:Text(
                'BOOK',
                style: TextStyle(
                  color: Colors.white,
                )
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              onPressed: (){
                Navigator.pop(context,venue.address);
                Navigator.pop(context,venue.address);
              },
              color: Colors.blue,
            )
          ]
        ),
      ),
    );
  }
}