import 'package:email_validator/email_validator.dart';
import 'package:event_sg/blocs/post_event_bloc.dart';
import 'package:event_sg/presentation/sub_pages/post_event.dart';
import 'package:event_sg/presentation/sub_pages/post_event2.dart';
import 'package:event_sg/presentation/sub_pages/post_venue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the stateful widget that the main application instantiates.
class PostPage extends StatefulWidget {
  const PostPage({Key key}) : super(key: key);


  @override
  _PostPageState createState() => _PostPageState();
}


class _PostPageState extends State<PostPage> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _autoValidate=true;
  bool organizerChanged=false;
  bool contactChanged=false;
  bool emailChanged=false;

  @override
  Widget build(BuildContext context) {
    //PostEventBloc _postEventBloc=PostEventBloc();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          elevation: 1.0,
          title: Text("Post"),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: 175,),
              FlatButton(
                child: Text(
                  " Event Post ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>EventPostSecond()),
                  );
                },
                color: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),

              SizedBox(height: 30,),
              FlatButton(
                child: Text(
                  " Venue Post ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>VenuePost()),
                  );
                },
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

