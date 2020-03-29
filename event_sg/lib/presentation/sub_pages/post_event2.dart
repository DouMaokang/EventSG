import 'dart:async';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event_sg/blocs/post_event_bloc.dart';
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
  bool postClicked=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
          },
        ),
        title: Align (
            alignment: Alignment(-0.25,0.0),
            child: const Text('Post an Event 2/2')
        ),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[

                SizedBox(height: 28,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "2. Event Details",
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    //height: 48,
                    child: TextFormField(
                      onChanged: (text) {nameChanged=true;postEventBloc.setName(text);},
                      validator: (value) {
                        if (!postClicked && !nameChanged) {postEventBloc.validateName(false);return null;}
                        if (value.length==0) {postEventBloc.validateName(false);return 'Event Name is mandatory';}
                        postEventBloc.validateName(true); return null;
                      },
                      textAlignVertical: TextAlignVertical.center,
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        //border: OutlineInputBorder(),
                        hintText: 'Event Name (*)',
                        labelText: 'Event Name (*)',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 10.0, // has the effect of softening the shadow
                            spreadRadius: 5.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              2.0, // vertical, move down 10
                            ),
                          )],
                          image:DecorationImage(
                            fit:BoxFit.fitWidth,
                            image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 36,),
                          FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            child: Text(
                              "+ Set Event Image",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {},
                            color: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 24,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    //height: 48,
                    child: DateTimeField(
                      onChanged: (text) {dateChanged=true;postEventBloc.setDate(text);},
                      validator: (value) {
                        if (!postClicked && !dateChanged) {postEventBloc.validateDate(false);return null;}
                        if (value==null) {postEventBloc.validateDate(false);return 'Date is mandatory';}
                        postEventBloc.validateDate(true); return null;
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
                        hintText: 'Event Date (*)',
                        labelText: 'Event Date (*)',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Container(
                        width: 175,
                        //height: 48,
                        child: DateTimeField(
                          onChanged: (text) {startChanged=true;postEventBloc.setStart(text);},
                          validator: (value) {
                            if (!postClicked && !startChanged) {postEventBloc.validateStart(false);return null;}
                            if (value==null) {postEventBloc.validateStart(false);return 'Starts Time is mandatory';}
                            postEventBloc.validateStart(true); return null;
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
                            hintText: 'Starts (*)',
                            labelText: 'Starts (*)',
                          ),
                        ),
                      ),

                      Container(
                        width: 175,
                        //height: 48,
                        child: DateTimeField(
                          onChanged: (text) {endChanged=true;postEventBloc.setEnd(text);},
                          validator: (value) {
                            if (!postClicked && !endChanged) {postEventBloc.validateEnd(false);return null;}
                            if (value==null) {postEventBloc.validateEnd(false);return 'Ends Time is mandatory';}
                            postEventBloc.validateEnd(true); return null;
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
                            hintText: 'Ends (*)',
                            labelText: 'Ends (*)',
                          ),
                        ),
                      ),
                    ],),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 48,
                    child: TextField(
                      onChanged: (text) {postEventBloc.setMaxCapacity(text);},
                      textAlignVertical: TextAlignVertical.center,
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        //border: OutlineInputBorder(),
                        hintText: 'Maximum Capacity',
                        labelText: 'Maximum Capacity',
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 48,
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
                        hintText: 'Registration Deadline',
                        labelText: 'Registration Deadline',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text (
                            "Location (*)",
                            style: TextStyle(fontSize:18),
                          ),
                          SizedBox(height:8,),
                          Padding(
                            padding:EdgeInsets.only(left:8),
                            child: FlatButton(
                              child: Text(
                                "+ Choose",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red)
                              ),
                              onPressed: () {},
                              color: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width:30,),
                      Text (
                          "// display location here\n"+"// second line _________\n"+"// third line ____________",
                          style: TextStyle(fontSize:18)),
                    ],
                  ),
                ),

                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 120,
                    child: TextField(
                      onChanged: (text) {postEventBloc.setEventDescription(text);},
                      textAlignVertical: TextAlignVertical.center,
                      //keyboardType: TextInputType.multiline,
                      maxLines: 6,
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
                SizedBox(height: 36,),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonBar(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.purple,
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
            ButtonBar(
                children: [
                  FlatButton(
                    child: Text(
                      " Post ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      postClicked=true;
                      if (_formKey.currentState.validate()) {
                        postEventBloc.post();
                        //dialog
                      }
                      Timer(Duration(seconds:2),() {postClicked=false;_formKey.currentState.validate();});
                    },
                    color: Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),

                ]
            ),
          ],
        ),
      ),
    );
  }
}
