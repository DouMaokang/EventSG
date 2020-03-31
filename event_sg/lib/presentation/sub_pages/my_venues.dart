import 'package:flutter/material.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/globals/login.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:http/http.dart' as http;

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
  final String userId = Login().getUserId();
  Future<List<Venue>> myVenues;
  VenueRepository venueRepository =
    VenueRepository(venueApiClient: VenueApiClient(httpClient:http.Client()));

  void initState() {
    // TODO: implement initState
    super.initState();
    myVenues = venueRepository.getVenueByOwnerId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Venues')),
      body: FutureBuilder<List<Venue>>(
        future: myVenues,
        builder: (context, snapshot) {
            if (snapshot.hasData){
              return buildVenueList(snapshot.data,context);
            }
            else if(snapshot.hasError){
              return Text('Error!');
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
    },
    ),
    );
  }

  Widget buildVenueList(List<Venue> venues,BuildContext context) {
    return Column(
      children: <Widget>[
        for (Venue venue in venues) buildVenueWidget(venue,context)
      ],
    );
  }


  Widget buildVenueWidget(Venue venue,BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VenueDetailPage(venue: venue)),
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
                  /*
                Container(
                  padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: Text(
                    DateFormat('dd/MM/yyyy hh:mm a').format(this.event.startTime).toString(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
                 */
                  Text(
                    venue.venueName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                  Text(
                    venue.area.toString() + 'm2' + ' ' * 8 + '\$' +
                        venue.rentalFee.toString() + ' per hour',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.location_city, size: 14,),
                        SizedBox(width: 6,),
                        Expanded(child: Text(
                          venue.address,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        )),
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
  }
}

