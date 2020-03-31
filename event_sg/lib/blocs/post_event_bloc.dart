import 'dart:math';

import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/globals/login.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/models/venue.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:frideos/frideos.dart';
import 'package:intl/intl.dart';

class PostEventBloc {

  /*
  String organizer;
  bool organizerValidation;
  String organization;
  String description;
  String contact;
  bool contactValidation;
  String email;
  bool emailValidation;
   */

  EventRepository eventRepository = EventRepository(
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );
  String userId=Login().getUserId();


  String name,description,maxCapacity,address,postal;
  DateTime date,start,end,ddl;
  Venue venue;
  //bool nameValidation,dateValidation,startValidation,endValidation;
  //bool locationValidation;

  void setName(text) {if (text.length==0) text=null;name=text;}
  void setDescription(text) {description=text;}
  void setDate(text) {date=text;}
  void setStart(text) {start=text;}
  void setEnd(text) {end=text;}
  void setMaxCapacity(text) {maxCapacity=text;}
  void setDDL(text) {ddl=text;}
  void setAddress(text) {if (text.length==0) text=null; address=text;}
  void setPostal(text) {if (text.length==0 || !validatePostal(text)) text=null; postal=text;}

  bool validatePostal(value) {
    Pattern pattern = r'\d{6}';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return false;
    return true;
  }
  /*
  void validateOrganizer(value) {organizerValidation=value;}
  void validateContact(value) {contactValidation=value;}
  void validateEmail(value) {emailValidation=value;}

  void validateName(value) {nameValidation=value;}
  void validateDate(value) {dateValidation=value;}
  void validateStart(value) {startValidation=value;}
  void validateEnd(value) {endValidation=value;}
  void validLocation() {
    //
  }
   */

  bool check() {
    print('name $name');
    print('date $date');
    print('start $start');
    print('end $end');
    print('address $address');
    print('postal $postal');
    //add logic of date and time period
    if (name!=null && date!=null && start!=null && end!=null && address!=null && postal!=null) {
      print('good');
      return true;
    }
    print('not good');
    return false;
  }

  void post() {
    if (check()) {
      Event event = Event(
          title:name,
          description: description,
          capacity: maxCapacity==null? 0:int.parse(maxCapacity),
          registrationDeadline:ddl,
          startTime: DateTime(date.year,date.month,date.day,start.hour,start.minute),
          endTime: DateTime(date.year,date.month,date.day,end.hour,end.minute),
          venue: venue,
          status: 'posted',
          organizerId: userId,
      );
      eventRepository.postEvent(event);
    }
  }
  void save() {
    Event event = Event(
        title:name,
        description: description,
        capacity: maxCapacity==null? 0:int.parse(maxCapacity),
        registrationDeadline:ddl,
        startTime: (date!=null && start!=null)?DateTime(date.year,date.month,date.day,start.hour,start.minute):null,
        endTime: (date!=null && end!=null)?DateTime(date.year,date.month,date.day,end.hour,end.minute):null,
        venue: venue,
        organizerId: userId,
    );
    eventRepository.saveDraftEvent(event);
  }

  void dispose() {}
}
/*
import 'package:bloc/bloc.dart';
import 'package:event_sg/blocs/post_event_event.dart';
import 'package:event_sg/blocs/post_event_state.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/cupertino.dart';

class PostEventBloc extends Bloc<PostEventEvent,PostEventState> {
  final EventRepository eventRepository;

  PostEventBloc(this.eventRepository);

  @override
  // TODO: implement initialState
  PostEventState get initialState => PostEventState();

  @override
  Stream<PostEventState> mapEventToState(PostEventEvent event) {
    // TODO: implement mapEventToState
    if (event is PostEventNext) {

    }
    return null;
  }

}

 */
