import 'package:event_sg/models/review.dart';
import 'package:event_sg/presentation/components/event_feedback/feedback_list_item.dart';
import 'package:flutter/material.dart';

class FeedbackList extends StatelessWidget {
  final List<Review> reviews;

  FeedbackList({@required this.reviews}) : assert(reviews != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildFeedbacks(),
    );
  }

  Widget _buildFeedbacks() {
    List<Widget> feedbackList = new List<Widget>();
    for(var i = 0; i < reviews.length; i++){
      feedbackList.add(FeedbackListItem(review: reviews[i]));
      feedbackList.add(Divider());
    }
    return Container(
      child: Column(
          children: feedbackList
      ),
    );
  }

}