import 'package:frideos/frideos.dart';

class PostEventBloc {

  String organizer;
  bool organizerValidation;
  String organization;
  String description;
  String contact;
  bool contactValidation;
  String email;
  bool emailValidation;

  String name,eventDescription,maxCapacity,ddl;
  DateTime date,start,end;
  bool nameValidation,dateValidation,startValidation,endValidation;
  bool locationValidation;

  PostEventBloc() {
    //organizer.onChange(checkForm);
    organizerValidation=false;
    contactValidation=false;
    emailValidation=false;
    nameValidation=false;
    dateValidation=false;
    startValidation=false;
    emailValidation=false;
    locationValidation=false;
  }
  void setOrganizer(text) {
    organizer=text;
  }
  void setOrganization(text) {
    organization=text;
  }
  void setDescription(text) {
    description=text;
  }
  void setContact(text) {
    contact=text;
  }
  void setEmail(text) {
    email=text;
  }

  void setName(text) {name=text;}
  void setEventDescription(text) {eventDescription=text;}
  void setDate(text) {date=text;}
  void setStart(text) {start=text;}
  void setEnd(text) {end=text;}
  void setMaxCapacity(text) {maxCapacity=text;}
  void setDDL(text) {ddl=text;}

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

  bool check1stPage() {
    if (organizerValidation && contactValidation && emailValidation) {
      print ('1good');
      return true;
    }
    return false;
  }

  bool check2ndPage() {
    locationValidation=true;
    if (nameValidation && dateValidation && startValidation && endValidation) {
      print ('2good');
      return true;
    }
    return false;
  }

  bool check() {
    bool b1=check1stPage(),b2=check2ndPage();
    return (b1 && b2);
  }

  void post() {
    check();
    print('good');
  }

  void dispose() {}
}
final postEventBloc = PostEventBloc();
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
