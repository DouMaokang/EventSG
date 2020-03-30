import 'package:event_sg/models/review.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

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
      feedbackList.add(_buildRow(reviews[i]));
      feedbackList.add(Divider());
    }
    return Container(
      child: Column(
          children: feedbackList
      ),
    );
  }

  Widget _buildRow(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // ----------------- lower part --------------------------------------
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                      child: new Container(
                          padding: new EdgeInsets.only(left: 13.0, bottom: 13.0),
                          child: ExpandableNotifier(
                            child: ScrollOnExpand(
                              child: ExpandablePanel(
                                header: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Container(
                                    height: 60,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                        // ---------------- avatar --------------------damn...--------------
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          width: 40.0,
                                                          height: 40.0,
                                                          decoration: new BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: new DecorationImage(
                                                                fit: BoxFit.fill,
                                                                // todo retrieve data from user repository and use as avartar
                                                                image: new NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                )
                                            ),
                                            Expanded(
                                                flex: 5,
                                                child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Flexible(
                                                            child: new Container(
                                                              padding: new EdgeInsets.only(right: 13.0),
                                                              child: new Text(
                                                                review.reviewerId.toString(), //todo 杀了我吧,get username with userid
                                                                overflow: TextOverflow.ellipsis,
                                                                style: new TextStyle(
                                                                  fontSize: 20.0,
                                                                  fontFamily: 'Roboto',
                                                                  fontWeight: FontWeight.bold,
                                                                  color: new Color(0xFF212121),
                                                                ),
                                                              ),
                                                            )
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children:
                                                            List.generate(5, (index) {
                                                              return Icon(
                                                                index < review.rating ? Icons.star : Icons.star_border,
                                                                size: 14,
                                                                color: Colors.amber,
                                                              );
                                                            }),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                                expanded: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    review.content,
                                    softWrap: true,
                                  ),
                                ),
                                collapsed: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    review.content,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ),
                          )
                      )
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}