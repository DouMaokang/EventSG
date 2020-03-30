import 'package:event_sg/globals/login.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:smooth_star_rating/smooth_star_rating.dart';

void main(){
  runApp(ReviewAddingPage());
}

class ReviewAddingPage extends StatefulWidget {
  String eventId;
  ReviewAddingPage({Key key, @required this.eventId}) : assert(eventId != null), super(key: key);

  @override
  _ReviewAddingPageState createState() => _ReviewAddingPageState();
}

class _ReviewAddingPageState extends State<ReviewAddingPage> {
  String eventId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _rating = 0.0;
  Map jsonMap = {
    "reviewerId": Login().getUserId(),
    "eventId": "",
    "rating": "",
    "content": ""
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(title: Text("Add a Review")),
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            children: <Widget>[
              const SizedBox(height: 36.0),
              Center(
                child: starBar(),
              ),
              contentInput(),
              const SizedBox(height: 26.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    highlightedBorderColor: Colors.black,
                    onPressed:  _submit,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _submit() async {
    jsonMap["rating"] = _rating;
    jsonMap["eventId"] = widget.eventId;
    print(jsonMap);
    if(_formKey.currentState.validate()){
      String url ='http://127.0.0.1:8080/api/review/add';
      String response = await apiRequest(url, jsonMap);
      if(response!="")
        _showDialog();
      else
        _showSuccessDialog();
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("There is an unknown error!."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Try again"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _showSuccessDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Review added!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();},
            ),
          ],
        );
      },
    );
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Widget starBar() {

    return Container(
      height: 70,
      child: SmoothStarRating(
        rating: _rating,
        size: 35,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        starCount: 5,
        allowHalfRating: false,
        spacing: 2.0,
        onRatingChanged: (value) {
          setState(() {
            _rating = value;
          });
        },
      ),
    );
  }

  Widget contentInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: 7,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
        labelText: "Feedback",
        hintText: "e.g This is an awesome event ...",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name)=> jsonMap["content"] = name,
    );
  }
}