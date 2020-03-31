import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/components/event_details/event_details_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:event_sg/globals/urls.dart';

class OwnerVenueDetailPage extends StatelessWidget{
  final Venue venue;
  OwnerVenueDetailPage({Key key,@required this.venue}):super(key:key);

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
                      image: AssetImage(venue.image),
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
              backgroundImage: AssetImage(venue.owner.image),
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
              venue.area.toString() + "m\u00b2"+' '*8+'\$' + venue.rentalFee.toString() + ' per hour',
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
              'Owner Contact Number',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              venue.owner.phoneNum.toString(),
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
          EventLocation(
            venueName: venue.venueName,
            venueAddress: venue.address,
            postalCode: venue.postalCode,
          ),
          SizedBox(height: 16),
//          new FlatButton(
//            padding: EdgeInsets.symmetric(vertical: 10),
//            color: Colors.blue,
//            child: Text(
//              "Delete",
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 16,
//              ),
//            ),
//            onPressed:() {
//              _showConfirmDialog(context);
//            },

        ],
        ),
      ),
    );
  }

//  void _showConfirmDialog(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Confirmation"),
//          content: new Text("Do you want to delete this button?"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Cancel"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            new FlatButton(
//              child: new Text("Confirm"),
//              onPressed: () {
//                _deleteVenue(context);
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

//  void _showDeletedDialog(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Deleted"),
//          content: new Text("The venue: ${venue.venueName} has been deleted!"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Done"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  void _deleteVenue(BuildContext context) async{
//    String url = '${Urls.apiUrlBase}/venue/delete/${venue.venueId}';
//    String response = await apiDeleteRequest(url);
//    _showDeletedDialog(context);
//  }
//
//  Future<String> apiDeleteRequest(String url) async {
//    HttpClient httpClient = new HttpClient();
//    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(url));
//    HttpClientResponse response = await request.close();
//    String reply = await response.transform(utf8.decoder).join();
//    httpClient.close();
//    return reply;
//  }

}