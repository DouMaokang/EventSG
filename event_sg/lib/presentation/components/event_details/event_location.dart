import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EventLocation extends StatefulWidget {
  // Define the center of the in-app map display.
  final String venueName;
  final String venueAddress;
  final int postalCode;
  EventLocation({this.venueName, this.venueAddress, this.postalCode});

  @override
  _EventLocationState createState() => _EventLocationState();
}

class _EventLocationState extends State<EventLocation> {
  @override
  void initState() {
    _convertAddressToLatLng(widget.venueAddress);
    _getCurrentLocation();
    super.initState();
  }

  final LatLng _center = const LatLng(1.360270, 103.811959);
  LatLng _venueLatLng;
  String _currentAddress;
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              height: 200,
//                padding: EdgeInsets.symmetric(vertical: 100),
              child: new GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.2,
                ),
                markers: Set<Marker>.of({
                  Marker(
                    markerId: MarkerId("1"),
                    infoWindow: InfoWindow(
                        title: "",
                        snippet: widget.venueAddress,
                        onTap: () {
                          _launchGoogleMapPlace();
                        }),
                    position: _venueLatLng,
                  )
                }),
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: Icon(Icons.directions_car, color: Colors.blue),
                      onPressed: () async {
                        _launchGoogleMapRoute(travelMode: "driving");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: Icon(Icons.directions_walk, color: Colors.blue),
                      onPressed: () async {
                        _launchGoogleMapRoute(travelMode: "walking");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: Icon(Icons.directions_bus, color: Colors.blue),
                      onPressed: () async {
                        _launchGoogleMapRoute(travelMode: "transit");
                      },
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

  _getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> p = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = p[0];
    setState(() {
      _currentAddress = "${place.name}, ${place.postalCode}, ${place.country}";
    });
  }

  _launchGoogleMapPlace() async {
    String destinationUrl = Uri.encodeComponent(
        "${widget.venueName}, ${widget.venueAddress}, ${widget.postalCode}, Singapore");
    final url =
        "https://www.google.com/maps/search/?api=1&query=$destinationUrl";
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGoogleMapRoute({String travelMode}) async {
    String originUrl = Uri.encodeComponent(_currentAddress);
    // TODO: change address format
    String destinationUrl = Uri.encodeComponent(
        "${widget.venueName}, ${widget.venueAddress}, ${widget.postalCode}, Singapore");
    String travelModeUrl = Uri.encodeComponent(travelMode);

    // This launches google map.
    final url =
        "https://www.google.com/maps/dir/?api=1&origin=$originUrl&destination=$destinationUrl&travelmode=$travelModeUrl";
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _convertAddressToLatLng(String address) async {
    // TODO: Change address format
    try {
      List<Placemark> p = await Geolocator()
          .placemarkFromAddress("Singapore ${widget.postalCode}");
      Placemark place = p[0];
      setState(() {
        _venueLatLng =
            LatLng(place.position.latitude, place.position.longitude);
      });
    } catch (e) {
      throw 'Could not translate $address';
    }
  }
}
