
import 'package:event_sg/globals/login.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/venue_repository.dart';

class VenueChooseBloc {

  String userId=Login().getUserId();
  VenueRepository venueRepository = VenueRepository(
    venueApiClient: VenueApiClient(httpClient: http.Client()),
  );


  Future<List<Venue>> getAllVenues() async {
    return await venueRepository.getAllVenues();
    /*
    List<Venue> venues=List<Venue>();
    User owner=User(userName:'ck',contactNumber: '66666',email:'123345@qq.com');
    venues.add(Venue(owner:owner,venueId:'1',address:'It has a long long address.',postalCode: 111111,rentalFee: 10,area:100,description: 'Very Good\nGood\nGood Description!!!',venueName: 'NTU'));
    print(venues[0].venueName);
    return Future.delayed(Duration(seconds: 1), () => venues);
     */
  }

}