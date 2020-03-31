import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/components/event_details/event_details_widgets.dart';
import 'package:expandable/expandable.dart';
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new NetworkImage(
                          'http://www.obrienprinting.com/wp-content/uploads/2013/09/logo-icon.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200,
                ),
              )),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              child: Text(
                venue.venueName,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              //backgroundImage: AssetImage(venue.owner.image),
            ),
            title: Text(
              venue.owner.userName,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              child: Text(
                "Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.topLeft,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Area & Rental Fee'),
            subtitle: Text(
              venue.area.toString() + 'm2'+' '*8+'\$' + venue.rentalFee.toString() + ' per hour',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Divider(
            height: 0,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(
              'Owner Contact Number & Email',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              '65-'+venue.owner.phoneNum.toString()+' '*8+venue.owner.email,
              style: TextStyle(fontSize: 14),
            ),
          ),
          ExpandableNotifier(
            child: ScrollOnExpand(
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    child: Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    venue.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    venue.description,
                    softWrap: true,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),
          /*
          EventLocation(
            venueName: venue.venueName,
            venueAddress: venue.address,
            postalCode: venue.postalCode,
          ),

           */
          SizedBox(height: 16,),
        ],
        ),
      ),

      bottomNavigationBar:Container(
        child:FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Colors.blue,
          child: Text(
            "Book it!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, venue);
            Navigator.pop(context, venue);
          },
        )
      ),
    );
  }
}