import 'package:event_sg/blocs/venue_choose_bloc.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/sub_pages/venue_detail_page.dart';
import 'package:flutter/material.dart';

class VenueChoosePage extends StatelessWidget {
  final VenueChooseBloc venueChooseBloc=new VenueChooseBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
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
            return Center(child:CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
Widget buildVenueList(List<Venue> venues,BuildContext context) {
  return SingleChildScrollView(
    child:Column(
      children: <Widget>[
        for (Venue venue in venues) buildVenueWidget(venue,context)
      ],
    )
  );
}
Widget buildVenueWidget(Venue venue,BuildContext context) {

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VenueDetailPage(venue: venue)),
      );
    },
    child: Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: 120,
            decoration: BoxDecoration(
  //
              borderRadius: BorderRadius.circular(2.0),
              image: DecorationImage(
                image: NetworkImage(
                    'http://www.obrienprinting.com/wp-content/uploads/2013/09/logo-icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: Text(
                    venue.area.toString()+'m2'+' '*8+'\$'+venue.rentalFee.toString()+' per hour',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
                Container(
                    child:Text(
                      venue.venueName,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_city, size: 14,),
                      SizedBox(width: 6,),
                      Expanded(
                        child: Text(
                          venue.address,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
/*
  return Container (
  padding: EdgeInsets.all(16.0),
  //
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
  //
  Container(
  width: 150,
  height: 150,

  decoration: new boxdecoration(
  image: new decorationimage(
  image: new networkimage(
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

 */
}
