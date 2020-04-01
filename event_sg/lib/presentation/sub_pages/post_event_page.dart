import 'dart:async';

import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/sub_pages/venue_choose_page.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event_sg/blocs/post_event_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventPostPage extends StatefulWidget {
  const EventPostPage({Key key}) : super(key: key);

  @override
  _EventPostPageState createState() => _EventPostPageState();
}
class _EventPostPageState extends State<EventPostPage> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final addressController=TextEditingController();
  final time=DateTime.now();

  bool addressState=true;
  bool postalState=true;

  bool postClicked=false;
  bool postColor=false;
  bool venueColor=true;
  bool venueChoosed=false;

  String address;
  double _elevation=0;

  PostEventBloc postEventBloc=new PostEventBloc();

  @override
  Widget build(BuildContext context) {

    if (postEventBloc.check()) setState(() {postColor=true;});
    setState(() {address=null;});

    var _chooseVenue = (BuildContext context) async {
      Venue result=await Navigator.push(
          context,
          MaterialPageRoute(builder:(context)=>VenueChoosePage(),)
      );
      if (result!=null) {
        setState(() {
          venueChoosed = true;
        });
        addressController.text = result.venueName;
        postEventBloc.setAddress(result.address);
        postEventBloc.setVenue(result);
        if (postEventBloc.check()) setState(() {
          postColor = true;
        });
      }
    };
    var _onPressed = () {
      setState(() {
        postClicked = true;
      });
      if (postEventBloc.address==null) setState(() {
        _elevation=10;
      });
      if (_formKey.currentState.validate() && postEventBloc.address!=null) {
        postEventBloc.post(context);
        setState(() {
          postColor = true;
        });
        //dialog
      }

      Timer(Duration(milliseconds: 1500), () {
        setState(() {
          postClicked = false;
          _elevation=0;
        });
        if (_formKey.currentState != null) _formKey.currentState.validate();
      });

    };

    int countChar(var s) {
      int count=0;
      for (var c in s.split(" ")) if (c!='' && c!='\n') count++;
      return count;
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            title: Align (
                alignment: Alignment(-0.3,0.0),
                child: const Text('Post an Event')
            ),
          ),
        ),
        body: new GestureDetector(
          onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
          child:SingleChildScrollView(
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
                            postEventBloc.setName(text);
                            if (postEventBloc.check()) setState(() {postColor=true;});
                            else setState(() {postColor=false;});
                          },
                          validator: (value) {
                            if (!postClicked && value.length==0) {return null;}
                            if (value.length==0) {return 'Event Name is mandatory';}
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.center,
                          obscureText:false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            //border: OutlineInputBorder(),
                            helperText: ' ',
                            hintText: 'Event Name',
                            labelText: 'Event Name',
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        //height: 48,
                        child: DateTimeField(
                          onChanged: (text) {postEventBloc.setDate(text);if (postEventBloc.check()) setState(() {postColor=true;});
                            else setState(() {postColor=false;});
                          },
                          validator: (value) {
                            if (!postClicked && value==null) {return null;}
                            if (value==null) {return 'Date is mandatory';}
                            return null;
                          },
                          obscureText: false,
                          format: DateFormat("yyyy-MM-dd"),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                initialDate: currentValue ?? time.add(Duration(days:1)),
                                firstDate: time.add(Duration(days:1)),
                                lastDate: time.add(Duration(days:180)));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            //border: OutlineInputBorder(),
                            helperText: ' ',
                            hintText: 'Event Date',
                            labelText: 'Event Date',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Expanded(
                            //width: 175,
                            //height: 48,
                            child: DateTimeField(
                              onChanged: (text) {postEventBloc.setStart(text);if (postEventBloc.check()) setState(() {postColor=true;});
                                else setState(() {postColor=false;});
                              },
                              validator: (value) {
                                if (!postClicked && value==null) {return null;}
                                if (value==null) {return 'Starts Time is mandatory';}
                                if (postEventBloc.end!=null && value.isAfter(postEventBloc.end)) return 'Invalid time period';
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
                                hintText: 'Starts',
                                labelText: 'Starts',
                              ),
                            ),
                          ),

                          Expanded(
                            //width: 175,
                            //height: 48,
                            child: DateTimeField(
                              onChanged: (text) {postEventBloc.setEnd(text);if (postEventBloc.check()) setState(() {postColor=true;});
                                else setState(() {postColor=false;});
                              },
                              validator: (value) {
                                if (!postClicked && value==null) {return null;}
                                if (value==null) {return 'Ends Time is mandatory';}
                                if (postEventBloc.start!=null && value.isBefore(postEventBloc.start)) return 'Invalid time period';
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
                                hintText: 'Ends',
                                labelText: 'Ends',
                              ),
                            ),
                          ),
                        ],),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        //height: 48,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            postEventBloc.setMaxCapacity(text);
                            if (postEventBloc.check()) setState(() {postColor=true;});
                            else setState(() {postColor=false;});
                          },
                          validator: (value) {
                            if (!postClicked && value.length==0) {return null;}
                            if (value.length==0) {return 'Capacity is mandatory';}
                            return null;
                          },
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
                          validator: (value) {
                            if (!postClicked && value==null) {return null;}
                            if (value==null) {return 'Registration Deadline is mandatory';}
                            var _date=postEventBloc.date,_start=postEventBloc.start;
                            if (_date!=null && _start==null && value.isAfter(DateTime(_date.year,_date.month,_date.day,23,59))) return 'Registration should end before the event starts';
                            if (_date!=null && _start!=null && value.isAfter(DateTime(_date.year,_date.month,_date.day,_start.minute,_start.second))) return 'Registration should end before the event starts';
                            return null;
                          },
                          onChanged: (text) {
                            postEventBloc.setDDL(text);
                            if (postEventBloc.check()) setState(() {postColor=true;});
                            else setState(() {postColor=false;});
                          },
                          obscureText: false,
                          format: DateFormat("yyyy-MM-dd HH:mm"),
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                                context: context,
                                firstDate: time,
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: time.add(Duration(days: 365)));
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
                          enabled: false,
                          controller: addressController,
                          onChanged: (text) {
                            postEventBloc.setAddress(text);
                            if (postEventBloc.check()) setState(() {postColor=true;});
                            else setState(() {postColor=false;});
                            //setState(() {
                             // addressState=text.length==0;
                              //venueColor=addressState && postalState;
                            //});
                          },
                          textAlignVertical: TextAlignVertical.center,
                          obscureText:false,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,//venueChoosed?UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)):InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                            //border: OutlineInputBorder(),
                            //helperText: ' ',
                            labelText: venueChoosed?'Venue':'Please click the button to choose a venue',
                            labelStyle:TextStyle(
                              color:venueChoosed?Colors.grey:Colors.black
                            )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child:SizedBox(
                        width:double.infinity,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "+ Choose a Venue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          elevation: _elevation,
                          onPressed: () {_chooseVenue(context);},
                          color: venueColor?Colors.blue:Colors.grey,
                        ),
                      ),
                    ),

                    SizedBox(height: 38,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 200,
                        child: TextFormField(
                          onChanged: (text) {
                            postEventBloc.setDescription(text);
                            if (postEventBloc.check()) setState(() {postColor=true;});
                            else setState(() {postColor=false;});
                          },
                          validator: (value) {
                            if (!postClicked && value.length==0) {return null;}
                            if (countChar(value)<10) {return 'At least ${10-countChar(value)} more word(s) are needed!';}
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.center,
                          //keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          obscureText:false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            helperText: ' ',
                            hintText: 'Event Description',
                            labelText: 'Event Description',
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width:double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            " Post ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: _onPressed,
                          color: postColor?Colors.blue:Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
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
