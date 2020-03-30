import 'dart:async';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event_sg/blocs/post_event_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class EventPostSecond extends StatefulWidget {
  const EventPostSecond({Key key}) : super(key: key);


  @override
  _EventPostSecondState createState() => _EventPostSecondState();
}
class _EventPostSecondState extends State<EventPostSecond> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool nameChanged=false;
  bool dateChanged=false;
  bool startChanged=false;
  bool endChanged=false;
  bool addressChanged=false;
  bool postalChanged=false;

  bool addressState=true;
  bool postalState=true;

  bool postClicked=false;
  bool postColor=postEventBloc.check();
  bool venueColor=true;

  @override
  Widget build(BuildContext context) {

    if (postEventBloc.check()) setState(() {postColor=true;});
    var _chooseVenue = () {};
    var _onPressed = () {
      postClicked = true;
      if (_formKey.currentState.validate()) {
        postEventBloc.post();
        postColor = true;
        //dialog
      }
      Timer(Duration(seconds: 2), () {
        postClicked = false;
        if (_formKey.currentState != null) _formKey.currentState.validate();
      });
    };

    return Scaffold(
        appBar: AppBar(
          title: Align (
              alignment: Alignment(-0.3,0.0),
              child: const Text('Post an Event')
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 35,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "  Event Details",
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      //height: 48,
                      child: TextFormField(
                        onChanged: (text) {
                          nameChanged=true;postEventBloc.setName(text);
                          if (postEventBloc.check()) setState(() {postColor=true;});
                          else setState(() {postColor=false;});
                        },
                        validator: (value) {
                          if (!postClicked && !nameChanged) {return null;}
                          if (value.length==0) {return 'Event Name is mandatory';}
                          return null;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        obscureText:false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          //border: OutlineInputBorder(),
                          helperText: ' ',
                          hintText: 'Event Name (*)',
                          labelText: 'Event Name (*)',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      //height: 48,
                      child: DateTimeField(
                        onChanged: (text) {dateChanged=true;postEventBloc.setDate(text);if (postEventBloc.check()) setState(() {postColor=true;});
                          else setState(() {postColor=false;});
                        },
                        validator: (value) {
                          if (!postClicked && !dateChanged) {return null;}
                          if (value==null) {return 'Date is mandatory';}
                          return null;
                        },
                        obscureText: false,
                        format: DateFormat("yyyy-MM-dd"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              initialDate: currentValue ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030));
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          //border: OutlineInputBorder(),
                          helperText: ' ',
                          hintText: 'Event Date (*)',
                          labelText: 'Event Date (*)',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                          width: 175,
                          //height: 48,
                          child: DateTimeField(
                            onChanged: (text) {startChanged=true;postEventBloc.setStart(text);if (postEventBloc.check()) setState(() {postColor=true;});
                              else setState(() {postColor=false;});
                            },
                            validator: (value) {
                              if (!postClicked && !startChanged) {return null;}
                              if (value==null) {return 'Starts Time is mandatory';}
                              return null;
                            },
                            obscureText: false,
                            format: DateFormat("HH:mm"),
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
                              );
                              return DateTimeField.convert(time);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              //border: OutlineInputBorder(),
                              helperText: ' ',
                              hintText: 'Starts (*)',
                              labelText: 'Starts (*)',
                            ),
                          ),
                        ),

                        Container(
                          width: 175,
                          //height: 48,
                          child: DateTimeField(
                            onChanged: (text) {endChanged=true;postEventBloc.setEnd(text);if (postEventBloc.check()) setState(() {postColor=true;});
                              else setState(() {postColor=false;});
                            },
                            validator: (value) {
                              if (!postClicked && !endChanged) {return null;}
                              if (value==null) {return 'Ends Time is mandatory';}
                              return null;
                            },
                            obscureText: false,
                            format: DateFormat("HH-mm"),
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
                              );
                              return DateTimeField.convert(time);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              //border: OutlineInputBorder(),
                              helperText: ' ',
                              hintText: 'Ends (*)',
                              labelText: 'Ends (*)',
                            ),
                          ),
                        ),
                      ],),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      //height: 48,
                      child: TextField(
                        onChanged: (text) {postEventBloc.setMaxCapacity(text);},
                        textAlignVertical: TextAlignVertical.center,
                        obscureText:false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          //border: OutlineInputBorder(),
                          helperText: ' ',
                          hintText: 'Maximum Capacity',
                          labelText: 'Maximum Capacity',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      //height: 48,
                      child: DateTimeField(
                        onChanged: (text) {postEventBloc.setDDL(text);},
                        obscureText: false,
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              initialDate: currentValue ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030));
                          if (date!=null) {
                            final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date,time);
                          } else return currentValue;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          //border: OutlineInputBorder(),
                          helperText: ' ',
                          hintText: 'Registration Deadline',
                          labelText: 'Registration Deadline',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      //height: 48,
                      child: TextFormField(
                        onChanged: (text) {
                          addressChanged=true;postEventBloc.setAddress(text);
                          if (postEventBloc.check()) setState(() {postColor=true;});
                          else setState(() {postColor=false;});
                          setState(() {
                            addressState=text.length==0;
                            venueColor=addressState && postalState;
                          });
                        },
                        validator: (value) {
                          if (!postClicked && !addressChanged) {return null;}
                          if (value.length==0) {return 'Event Address is mandatory';}
                          return null;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        obscureText:false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          //border: OutlineInputBorder(),
                          helperText: ' ',
                          hintText: 'Event Address (*)',
                          labelText: 'Event Address (*)',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          //height: 48,
                          width:180,
                          child: TextFormField(
                            onChanged: (text) {
                              postalChanged=true;postEventBloc.setPostal(text);
                              if (postEventBloc.check()) setState(() {postColor=true;});
                              else setState(() {postColor=false;});
                              setState(() {
                                postalState=text.length==0;
                                venueColor=addressState && postalState;
                              });
                            },
                            validator: (value) {
                              if (!postClicked && !postalChanged) {return null;}
                              if (value.length==0) {return 'Postal Code is mandatory';}
                              Pattern pattern = r'\d{6}';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value)) return 'Invalid Postal Code';
                              return null;
                            },
                            textAlignVertical: TextAlignVertical.center,
                            obscureText:false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              //border: OutlineInputBorder(),
                              helperText: ' ',
                              hintText: 'Postal Code (*)',
                              labelText: 'Postal Code (*)',
                            ),
                          ),
                        ),
                        RaisedButton(
                          child: Text(
                            "+ Choose a Venue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            //side: BorderSide(color: Colors.red)
                          ),
                          onPressed: _chooseVenue,
                          color: venueColor?Colors.blue:Colors.grey,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 38,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 120,
                      child: TextField(
                        onChanged: (text) {postEventBloc.setEventDescription(text);},
                        textAlignVertical: TextAlignVertical.center,
                        //keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        obscureText:false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                          hintText: 'Event Description',
                          labelText: 'Event Description',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 28,),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "( All * entries are mandatory )",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        /*
                      ButtonBar(
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),

                              child: Row(
                                  children: <Widget>[
                                    Icon(Icons.arrow_back),
                                    Text(
                                      "Back ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ]
                      ),
                         */
                      ButtonBar(
                          children: [
                            FlatButton(
                              child: Text(
                                " Save ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  //Save
                                }
                              },
                              color: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            ),

                          ]
                      ),
                      RaisedButton(
                        child: Text(
                          " Post ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: _onPressed,
                        color: postColor?Colors.blue:Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
    /*
    bottomNavigationBar: BottomAppBar(
      color: Colors.blue,
    ),
    */
    );
  }
}
