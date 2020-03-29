import 'package:email_validator/email_validator.dart';
import 'package:event_sg/blocs/post_event_bloc.dart';
import 'package:event_sg/presentation/sub_pages/post_event2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the stateful widget that the main application instantiates.
class VenuePost extends StatefulWidget {
  const VenuePost({Key key}) : super(key: key);


  @override
  _VenuePostState createState() => _VenuePostState();
}


class _VenuePostState extends State<VenuePost> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _autoValidate=true;
  bool organizerChanged=false;
  bool contactChanged=false;
  bool emailChanged=false;

  final organizerController=TextEditingController();
  final organizationController=TextEditingController();
  final descriptionController=TextEditingController();
  final contactController=TextEditingController();
  final emailController=TextEditingController();

  @override
  // ignore: must_call_super
  void dispose() {
    super.dispose();
    organizationController.dispose();
    organizerController.dispose();
    descriptionController.dispose();
    contactController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //PostEventBloc _postEventBloc=PostEventBloc();
    return Scaffold(
      appBar: AppBar(
        title: Align (
            alignment: Alignment(-0.25,0.0),
            child: const Text('Post a Venue')
        ),

      ),
      /*
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: <Widget>[
                SizedBox(height: 28,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "1. Organization Information",
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
                      controller: organizerController,
                      onChanged: (text) {organizerChanged=true;postEventBloc.setOrganizer(text);},
                      validator: (value) {
                        if (!organizerChanged) {postEventBloc.validateOrganizer(false);return null;}
                        if (value.length==0) {postEventBloc.validateOrganizer(false);return 'Organizer is mandatory';}
                        postEventBloc.validateOrganizer(true);return null;
                      },
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        //border: OutlineInputBorder(),
                        hintText: 'Organizer (*)',
                        labelText: 'Organizer (*)',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    //height: 48,
                    child: TextField(
                      controller: organizationController,
                      onChanged: (text) {postEventBloc.setOrganization(text);},
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        //border: OutlineInputBorder(),
                        hintText: 'Organization Name',
                        labelText: 'Organization Name',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    //height: 48,
                    child: TextFormField(
                      controller: contactController,
                      onChanged: (text) {contactChanged=true;postEventBloc.setContact(text);},
                      validator: (value) {
                        if (!contactChanged) {postEventBloc.validateContact(false);return null;}
                        if (value.length==0) {postEventBloc.validateContact(false);return 'Contact Number is mandatory';}
                        Pattern pattern = r'[8-9]\d{7}';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value)) {postEventBloc.validateContact(false);return 'Invalid Singapore mobile number';}
                        postEventBloc.validateContact(true); return null;
                      },
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        //border: OutlineInputBorder(),
                        hintText: 'Contact Number (*)',
                        labelText: 'Contact Number (*)',
                        //errorText: validateContact(contactController.text),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    //height: 48,
                    child: TextFormField(
                      controller: emailController,
                      onChanged: (text) {emailChanged=true;postEventBloc.setDescription(text);},
                      validator: (value) {
                        if (!emailChanged) {postEventBloc.validateEmail(false);return null;}
                        if (value.length==0) {postEventBloc.validateEmail(false);return 'Email Address is mandatory';}
                        Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value)) {postEventBloc.validateEmail(false);return 'Invalid email address';}
                        postEventBloc.validateEmail(true);return null;
                      },
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        //border: OutlineInputBorder(),
                        hintText: 'Email Address (*)',
                        labelText: 'Email Address (*)',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    //height: 120,
                    child: TextField(
                      //keyboardType: TextInputType.multiline,
                      controller: descriptionController,
                      onChanged: (text) {postEventBloc.setDescription(text);},
                      maxLines: 6,
                      obscureText:false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: 'Organization Descripton',
                        labelText: 'Organization Descripton',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),


                SizedBox(height: 8,),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "( All * entries are mandatory )",
                      ),
                    ],
                  ),
                ),
                SizedBox(height:40,),
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
                    onPressed: () {
                      /*
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }
                      */
                      postEventBloc.check1stPage();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>EventPostSecond()),
                      );
                    },
                    color: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),

                    child: Row(
                        children: <Widget>[
                          Text(
                            " Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.arrow_forward),
                        ]
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),

       */
    );
  }
}
