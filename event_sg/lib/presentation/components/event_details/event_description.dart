import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class EventDescription extends StatelessWidget {

  final String description;

  EventDescription({Key key, @required this.description})
    : assert(description != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              child: Text(
                "Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

              ),
              alignment: Alignment.topLeft,
            ),
          ),
          collapsed: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              this.description,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,),
          ),
          expanded: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              this.description,
              softWrap: true, ),
          ),
        ),
      ),
    );

  }
}
