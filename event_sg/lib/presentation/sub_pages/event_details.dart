import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/components/event_details/event_details_widgets.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/event_details/event_header.dart';
import '../components/event_details/organizer_avatar.dart';
import 'package:http/http.dart' as http;


/// This is the stateful widget that the main application instantiates.
class EventDetailsPage extends StatelessWidget {

//  final EventRepository eventRepository = EventRepository(
//    // Add all required repositories here.
//    eventApiClient: EventApiClient(httpClient: http.Client()),
//  );

  final RegistrationRepository registrationRepository = RegistrationRepository(
    // Add all required repositories here.
    registrationApiClient: RegistrationApiClient(httpClient: http.Client()),
  );

  final String eventId;


  EventDetailsPage({Key key,
    @required this.eventId,
  })
      : super(key: key);

  @override
  Widget build(context) {
    final SingleEventBloc singleEventBloc = BlocProvider.of<SingleEventBloc>(context);

    return BlocBuilder<SingleEventBloc, SingleEventState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is SingleEventEmpty) {
          singleEventBloc.add(
              SingleEventClicked(eventId: this.eventId));
          return Center(child: CircularProgressIndicator());
        } else if (state is SingleEventLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SingleEventError) {
          return Text(
            'Something went wrong!',
            style: TextStyle(color: Colors.red),
          );
        } else if (state is SingleEventLoaded) {
          // final singleEvent = state.event;

          return Scaffold(
            appBar: EventTopBar(),

            body: SingleChildScrollView(
              child: Center(
                child:  Column(
                  children: <Widget>[
                    EventHeader(
                      url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSy-W7gF6wc8shk2xxKWEt_JSLPiYG3G7c6kibQveo-RICfiCUp',
                      eventName: state.event.title,),
                    SizedBox(height: 16,),
                    OrganizerAvatar(organizer: state.event.organizer),
                    EventRegistration(
                      startTime: state.event.startTime,
                      endTime: state.event.endTime,
                      registrationDeadline: state.event.registrationDeadline,
                      capacity: state.event.capacity,
                      numOfParticipants: state.event.numOfParticipants,
                    ),
                    SizedBox(height: 16,),
                    EventDescription(description: state.event.description),
                    SizedBox(height: 24,),
                    EventLocation(
                      venueName: state.event.venue.venueName,
                      venueAddress: state.event.venue.address,
                      postalCode: state.event.venue.postalCode,
                    ),
                    EventFooter(),
                  ],
                ),
              ),
            ),

            bottomNavigationBar: BlocProvider<RegistrationBloc>(
              create: (context) => RegistrationBloc(registrationRepository: registrationRepository),
              child: EventRegistrationBar(
                eventId: eventId,
                eventDateTime: state.event.startTime,
                eventTitle: state.event.title,
                // TODO: get user id. how?
                userId: "3b41e41f-1b4b-4708-98ec-28145d2c4e6a",
                key: UniqueKey(),
              ),
            ),
          );
        }
      },
    );
  }


}
