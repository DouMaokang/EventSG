import 'package:email_validator/email_validator.dart';
import 'package:event_sg/blocs/post_event_bloc.dart';
import 'package:event_sg/presentation/sub_pages/post_event.dart';
import 'package:event_sg/presentation/sub_pages/post_event_page.dart';
import 'package:event_sg/presentation/sub_pages/post_venue.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sub_pages/post_venue.dart';

/// This is the stateful widget that the main application instantiates.
class PostPage extends StatefulWidget {
  const PostPage({Key key}) : super(key: key);


  @override
  _PostPageState createState() => _PostPageState();
}


class _PostPageState extends State<PostPage> {

  @override
  Widget build(BuildContext context) {
    //PostEventBloc _postEventBloc=PostEventBloc();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            centerTitle: true,
            elevation: 1.0,
            title: Text("Post"),
          ),
        ),

      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            SizedBox(height: 70,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  height: 168,
                  decoration: BoxDecoration(color: Colors.blue[50]),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(builder: (context)=>EventPostPage()),
                        );
                      },
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 4, 0),

                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Events",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28
                              ),
                            ),
                            SizedBox(width: 6,),
                            Icon(Icons.local_activity, color: Colors.black, size: 28),
                          ],
                        ),
                      ),

                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Post an awesome event",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),

                      trailing: Icon(Icons.chevron_right, size: 28,),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  height: 168,
                  decoration: BoxDecoration(color: Colors.blue[50]),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>VenuePostingPage()),
                        );
                      },
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 4, 0),

                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Venues",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28
                              ),
                            ),
                            SizedBox(width: 6,),
                            Icon(Icons.weekend, color: Colors.black, size: 28),
                          ],
                        ),
                      ),

                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "List an exclusive venue",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),

                      trailing: Icon(Icons.chevron_right, size: 28,),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    )
    );
  }
}

