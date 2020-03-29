import 'package:flutter/material.dart';

import '../../sub_pages/events_saved.dart';

class EventTopBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Align (
            alignment: Alignment.centerLeft,
            child: const Text('Event Details')
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Show saved events',
            onPressed: (){}// => Navigator.of(context)
                //.push(MaterialPageRoute(builder: (_) => EventSaved())),

          ),
        ],

      ),
    );
  }
}
