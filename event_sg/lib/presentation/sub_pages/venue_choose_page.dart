import 'package:event_sg/blocs/venue_choose_bloc.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/sub_pages/venue_detail_page.dart';
import 'package:flutter/material.dart';

class VenueChoosePage extends StatelessWidget {
  final VenueChooseBloc venueChooseBloc=new VenueChooseBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Venue List'),),
      body: FutureBuilder<List<Venue>>(
        future: venueChooseBloc.getAllVenues(),
        builder: (BuildContext context, AsyncSnapshot<List<Venue>> snapshot) {
          if (snapshot.hasData){
            return buildVenueList(snapshot.data,context);
          }
          else if(snapshot.hasError){
            //return Text('Error!');
            return Text(snapshot.data[0].venueName);
          }
          else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
Widget buildVenueList(List<Venue> venues,BuildContext context) {
  return Column(
    children: <Widget>[
      for (Venue venue in venues) buildVenueWidget(venue,context)
    ],
  );
}
Widget buildVenueWidget(Venue venue,BuildContext context) {


  return Container (
  padding: EdgeInsets.all(16.0),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
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
          SizedBox(width: 10,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
                  Text(
                    venue.venueName+'\n',
                    style: TextStyle(
                        color: Colors.black, fontSize: 18),

                  ),
                  /*
                  WidgetSpan(
                    child: Icon(Icons.location_on, color: Colors.blue,
                        size: 14),
                  ),
                   */
                  Text(
                    venue.address+'\n',
                    style: TextStyle(
                        color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    "${venue.area} m2\n",
                    style: TextStyle(
                        color: Colors.black, fontSize: 14),
                  ),
                  FlatButton(
                    child:Text(
                      "view details",
                      style: TextStyle(
                          color: Colors.white, fontSize: 14),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context)=>VenueDetailPage(venue:venue,),)
                      );
                    },
                    color: Colors.blue,
                  ),

            ],
              ),
            ],
          ),
        );
}
