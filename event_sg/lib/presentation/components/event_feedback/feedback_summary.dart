import 'package:event_sg/models/review.dart';
import 'package:flutter/material.dart';

class FeedbackSummary extends StatelessWidget {
  final List<Review> reviews;

  FeedbackSummary({@required this.reviews}) : assert(reviews != null);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < reviews.length; i++) {
      print(reviews[i].reviewerId);
    }
    return Container(
      width: 400,
      child: Card(
          child: Row(  // first tier row
            children: <Widget>[
              // ----------------------------- column 1 -------------------------------
              Expanded(
                  flex: 5,
                  child: Column( // left
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 0, left: 14),
                        child: Text(
                          _getOverallRating(reviews),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 44,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8, left: 12, top: 4),
                        child: Text(
                          _getLength(reviews).toString() + " " + plural(_getLength(reviews)),
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              // ----------------------------- column 2 -------------------------------
              Expanded(
                flex:3,
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _stars(5),
                        _stars(4),
                        _stars(3),
                        _stars(2),
                        _stars(1)
                      ],
                    )
                  ],
                ),
              ),
              // ----------------------------- column 3 -------------------------------
              Expanded(
                flex:3,
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _numbers(_getIndividualNoRating(reviews, 5)),
                        _numbers(_getIndividualNoRating(reviews, 4)),
                        _numbers(_getIndividualNoRating(reviews, 3)),
                        _numbers(_getIndividualNoRating(reviews, 2)),
                        _numbers(_getIndividualNoRating(reviews, 1))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _stars(int number) {
    return Container(
        child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children:
                  List.generate(5, (index) {
                    return Icon(
                      index < number ? Icons.star : Icons.star_border,
                      size: 12,
                      color: Colors.amber,
                    );
                  }),
                ),
              )
            ]
        )
    );
  }

  Widget _numbers(int number) {
    return Container(
        child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  number.toString() + " " + plural(number),
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: "Roboto",
                      color: Colors.grey
                  ),
                ),
              )
            ]
        )
    );
  }

  int _getLength(List<Review> reviews) {
    return reviews.length;
  }

  String plural(int n) {
    if ( n > 1) {
      return 'Reviews';
    } else return 'Review';
  }

  String _getOverallRating(List<Review> reviews) {
    int noRating = _getLength(reviews);
    double sum = 0;
    for (int i=0; i<noRating; i++) {
      sum += reviews[i].rating;
    }
    String rounded = (sum/noRating).toStringAsFixed(1);
    return rounded;
  }

  int _getIndividualNoRating(List<Review> reviews, int rating) {
    int res = 0;
    for (int i = 0; i< reviews.length; i++) {
      if (reviews[i].rating == rating) {
        res += 1;
      }
    }
    return res;
  }
}