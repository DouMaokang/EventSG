import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class EventDescription extends StatelessWidget {
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
            child: Text("This is a wonderful event that you and your friends will enjoy. You should definately not miss this opportunity to join us!",
              softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          expanded: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("This is a wonderful event that you and your friends will enjoy. You should definately not miss this opportunity to join us! We have prepared various actities, food and drinks for you. Come and join us! You'll never regret your decision!",
              softWrap: true, ),
          ),
        ),
      ),
    );

  }
}
