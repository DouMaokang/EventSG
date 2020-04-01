import 'package:event_sg/globals/login.dart';
import 'package:event_sg/globals/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:http/http.dart' as http;


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

  final ReviewRepository reviewRepository = ReviewRepository(
      reviewApiClient: ReviewApiClient(httpClient: http.Client())
  );

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
          appBar: PreferredSize(child: AppBar(title: Text("Add Review")), preferredSize: Size.fromHeight(44.0),),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  const SizedBox(height: 36.0),
                  Container(
                    decoration: BoxDecoration(color: Colors.blue[50]),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Thanks for attending our event",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            SizedBox(width: 6,),
                            Icon(Icons.event_available, color: Colors.black, size: 20),
                          ],
                        ),
                      ),

                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Your feedback is much appreciated. Please leave a review here.",
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  Center(
                    child: starBar(),
                  ),
                  contentInput(),
                  const SizedBox(height: 34.0),

                  BlocProvider<AddReviewBloc>(
                    create: (context) => AddReviewBloc(reviewRepository: reviewRepository),

                    child: BlocBuilder<AddReviewBloc, AddReviewState>(
                      // ignore: missing_return
                        builder: (context, state) {
                          return FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              color: Colors.blue,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                _submit();
                                BlocProvider.of<AddReviewBloc>(context).add(AddReview());
                              }
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  void _submit() async {
    jsonMap["rating"] = _rating;
    jsonMap["eventId"] = widget.eventId;
    print(jsonMap);
    if(_formKey.currentState.validate()){
      String url ='${Urls.apiUrlBase}/review/add';
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
          content: new Text("There is an unknown error!"),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 2,
          backgroundColor: Colors.white,

          title: Text(
            'Review Comfirmation',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: ListBody(
              children: <Widget>[
                Text('Thanks for taking time to give us your review'),
                SizedBox(height: 8,),
                Text('Please click confirm button to send the review'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.bold),),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
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