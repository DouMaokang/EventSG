import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:uuid/uuid.dart';


/// This is the stateful widget that the main application instantiates.
class AddReviewPage extends StatefulWidget {
  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage>{
  User user;
  Event event;
  var _rating = 0.0;
  final TextEditingController _textController = TextEditingController();
  final ReviewRepository reviewRepository = ReviewRepository(
    // Add all required repositories here.
    reviewApiClient: ReviewApiClient(httpClient: http.Client()),
  );


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          tooltip: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align (
          alignment: Alignment.center,
          child: const Text('Add My Review'),
        ),
      ),
      body: BlocProvider<AddReviewBloc>( // todo add review bloc
        create: (context) => AddReviewBloc(reviewRepository: reviewRepository),
        child: SingleChildScrollView(
          child: Center(
            child:
            BlocBuilder<AddReviewBloc, AddReviewState>(  // todo  add review state
              // ignore: missing_return
              builder: (context, state) {
                if (state is AddReviewAdded) {
                  // BlocProvider.of<AddReviewBloc>(context).add(SingleEventClicked(eventId: event.eventId));
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: "Review Successfully Added!",
                    backgroundColor: Colors.grey,
                    textColor: Colors.black,
                    timeInSecForIosWeb: 1,
                    gravity: ToastGravity.BOTTOM
                  );
                } else if (state is AddReviewAdding) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddReviewError) {
                  return Text(
                    'Something went wrong!',
                    style: TextStyle(color: Colors.red),
                  );
                } else if (state is AddReviewEmpty){
                  // final singleEvent = state.event;
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 150,
                          child: SmoothStarRating(
                            rating: _rating,
                            size: 65,
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
                        ),
                        TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Leave your comments here'
                          ),
                        ),
                        RaisedButton(
                          textColor: Colors.white,
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            String reviewId = Uuid() as String;
                            Review review = Review(
                              reviewId: reviewId,
                              reviewerId: user.userId,
                              eventId: event.eventId,
                              rating: _rating as int,
                              content: _textController.text
                            );
                            // ?? reviewRepository.addReview(review);
                            // pop the review obj back with context?
                            if (review != null) {
                              BlocProvider.of<AddReviewBloc>(context).add(ConfirmReview(review: review));
                            }
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 16,)
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}






