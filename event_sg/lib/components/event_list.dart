import 'package:event_sg/components/event_list_item.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  EventList({
    Key key,
    this.itemList,
  }) : super(key: key);

  List<EventListItem> itemList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: ListTile.divideTiles(
        context: context,
        tiles: itemList,
      ).toList(),
    );
  }
}