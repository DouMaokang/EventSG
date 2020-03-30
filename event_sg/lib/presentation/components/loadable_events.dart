
import 'package:event_sg/models/models.dart';
import 'package:flutter/material.dart';

import 'event_list.dart';


class LoadableEvents extends StatefulWidget {
  LoadableEvents({Key key, this.eventList}) : super(key: key);
  final List<Event> eventList;

  @override
  _LoadableEventsState createState() => new _LoadableEventsState();
}

class _LoadableEventsState extends State<LoadableEvents> {

  int present = 0;
  int perPage = 5;

  var items = List<Event>();


  @override
  void initState() {

    super.initState();
    if (perPage <= widget.eventList.length) {
      setState(() {
        items.addAll(widget.eventList.getRange(present, present + perPage));
        present = present + perPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (perPage <= widget.eventList.length) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: (present <= widget.eventList.length)
            ? items.length + 1
            : items.length,
        itemBuilder: (context, index) {
          return (index == items.length) ?
          Container(
            child: FlatButton(
              child: Text("Load More",
                style: TextStyle(color: Colors.blue, fontSize: 14),),
              onPressed: () {
                setState(() {
                  if ((present + perPage) > widget.eventList.length) {
                    items.addAll(
                        widget.eventList.getRange(present, widget.eventList
                            .length));
                  } else {
                    items.addAll(
                        widget.eventList.getRange(present, present + perPage));
                  }
                  present = present + perPage;
                });
              },
            ),
          )
              :
          new EventListItem(event: widget.eventList[index]);
        },
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, int index) {
          return new EventListItem(event: widget.eventList[index]);
        },
        itemCount: widget.eventList.length,
      );
    }
  }
}