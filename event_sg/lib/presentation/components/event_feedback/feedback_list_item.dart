import 'dart:async';

import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/user_repository.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FeedbackListItem extends StatefulWidget {
  Review review;
  FeedbackListItem({Key key, @required this.review}) :
        assert(review != null),
        super(key: key);

  @override
  _FeedbackListItemState createState() => _FeedbackListItemState();
}

class _FeedbackListItemState extends State<FeedbackListItem> {

//  final NotificationRepository notificationRepository = NotificationRepository(
//      notificationApiClient: NotificationApiClient(httpClient: http.Client())
//  );

  final UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(httpClient: http.Client())
  );

  Future myFutureUser;

  @override
  void initState() {
    super.initState();
    // assign this variable your Future
    myFutureUser = userRepository.getUserById(widget.review.reviewerId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFutureUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return new Container();
          User user = snapshot.data;
          return new Padding(
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
                                padding: new EdgeInsets.only(
                                    left: 13.0, bottom: 13.0),
                                child: ExpandableNotifier(
                                  child: ScrollOnExpand(
                                    child: ExpandablePanel(
                                      header: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Container(
                                          height: 60,
                                          child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(
                                                  10.0, 10.0, 0.0, 0.0),
                                              // ---------------- avatar --------------------damn...--------------
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              5.0, 0.0, 0.0,
                                                              0.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              CircleAvatar(
                                                                radius: 20,
                                                                backgroundImage: AssetImage(user.image),
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child: Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              5.0, 0.0, 0.0,
                                                              0.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              new Flexible(
                                                                  child: new Container(
                                                                    padding: new EdgeInsets
                                                                        .only(
                                                                        right: 13.0),
                                                                    child: new Text(
                                                                      user
                                                                          .userName,
                                                                      overflow: TextOverflow
                                                                          .ellipsis,
                                                                      style: new TextStyle(
                                                                        fontSize: 20.0,
                                                                        fontFamily: 'Roboto',
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        color: new Color(
                                                                            0xFF212121),
                                                                      ),
                                                                    ),
                                                                  )
                                                              ),
                                                              Container(
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize
                                                                      .min,
                                                                  children:
                                                                  List.generate(
                                                                      5, (
                                                                      index) {
                                                                    return Icon(
                                                                      index <
                                                                          widget
                                                                              .review
                                                                              .rating
                                                                          ? Icons
                                                                          .star
                                                                          : Icons
                                                                          .star_border,
                                                                      size: 14,
                                                                      color: Colors
                                                                          .amber,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          widget.review.content,
                                          softWrap: true,
                                        ),
                                      ),
                                      collapsed: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          widget.review.content,
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            )
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

}
